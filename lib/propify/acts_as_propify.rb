module Propify
  module ActsAsPropify
    def initialize
       puts 'CONSTRUCTEUR' 
    end
      
    extend ActiveSupport::Concern
    
    included do end
    
    module ClassMethods
        def act_as_propify(options = {})
            create_propify_tables self.table_name
            create_propify_classes self.table_name
            
            include Propify::ActsAsPropify::LocalInstanceMethods
        end
        
        def propify_all 
            propify_all_inner
        end
        
        def propify_create name
            propify_create_inner name
        end
        
        def propify_delete id, name
            raise "Cannot remove propify without an id or a name" unless !id.nil? || name.blank?
            propify_delete_inner seld.table_name, id, name
        end
        
        protected
            def propify_delete_inner table_name, id, name
                
            end
        
            def propify_all_inner
                eval("#{self.table_name}_propify_fields").all
            end
            
            def propify_create_inner name
                eval("#{self.table_name}_propify_fields").create(:name => name)
            end
        
            def create_propify_tables table_name
               if !ActiveRecord::Base.connection.table_exists? "#{table_name}_propify_fields"
                    ActiveRecord::Migration.create_table "#{table_name}_propify_fields" do |t|
                      t.string  :name
                    end
                    
                    ActiveRecord::Migration.create_table " #{table_name}_propify_values" do |t|
                      t.string  :value
                      t.integer "#{table_name}_id"
                      t.integer "#{table_name}_propify_fields"
                    end
                end
            end
            
            def create_propify_classes
                Object.const_set("UsersPropifyField", Class.new(ActiveRecord::Base))
                Object.const_set("UsersPropifyValue", Class.new(ActiveRecord::Base))
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