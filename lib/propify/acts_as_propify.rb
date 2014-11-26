module Propify
  module ActsAsPropify
    def initialize
       puts 'CONSTRUCTEUR' 
    end
      
    extend ActiveSupport::Concern
    
    included do end
    
    module ClassMethods
        def act_as_propify(options = {})
            create_propify_tables
            create_propify_classes
            
            include Propify::ActsAsPropify::LocalInstanceMethods
        end
        
        def propify_all 
            propify_all_inner
        end
        
        def propify_create name
            propify_create_inner name
        end
        
        def propify_delete name
            propify_delete_inner name
        end
        
        protected
            def propify_delete_inner name
                obj = eval("UsersPropifyField").find_by_name(name)
                obj.destroy!
            end
        
            def propify_all_inner
                eval("UsersPropifyField").all
            end
            
            def propify_create_inner name
                eval("UsersPropifyField").create(:name => name)
            end
        
            def create_propify_tables
               if !ActiveRecord::Base.connection.table_exists? "#{self.table_name}_propify_fields"
                    ActiveRecord::Migration.create_table "#{self.table_name}_propify_fields" do |t|
                      t.string  :name
                    end
                    
                    ActiveRecord::Migration.create_table " #{self.table_name}_propify_values" do |t|
                      t.string  :value
                      t.integer "user_id"
                      t.integer "users_propify_field_id"
                    end
                end
            end
            
            def create_propify_classes
                Object.const_set("UsersPropifyField", Class.new(ActiveRecord::Base))
                Object.const_set("UsersPropifyValue", Class.new(ActiveRecord::Base) do
                    has_one "UsersPropifyFields".to_sym
                    belongs_to "Users".to_sym
                end)
            end
    end
    
    module LocalInstanceMethods
      def propify 
        #ActiveRecord::Base.connection.select_all "select * from #{self.table_name}_propify_values"
        10
      end
    end
  end
end

ActiveRecord::Base.send :include, Propify::ActsAsPropify