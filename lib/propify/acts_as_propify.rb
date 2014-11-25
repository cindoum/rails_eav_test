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
            
            include Propify::ActsAsPropify::LocalInstanceMethods
        end
        
        def propify_all 
            propify_all_inner self.table_name
        end
        
        def propify_create name
            propify_create_inner self.table_name, name
        end
        
        def propify_delete id, name
            raise "Cannot remove propify without an id or a name" unless !id.nil? || name.blank?
            propify_delete_inner seld.table_name, id, name
        end
        
        protected
            def propify_delete_inner table_name, id, name
                if !id.nil?
                    ActiveRecord::Base.connection.delete "delete from #{table_name}_propify_fields where id = ?", "SQL", [id]
                else
                    ActiveRecord::Base.connection.delete "delete from #{table_name}_propify_fields where name = ?", "SQL", [name]
                end
            end
        
            def propify_all_inner table_name
                ActiveRecord::Base.connection.select_all "select * from #{table_name}_propify_fields"
            end
            
            def propify_create_inner table_name, name
                ActiveRecord::Base.connection.insert "insert into #{table_name}_propify_fields (name) values (?)", "SQL", [name]
            end
        
            def create_propify_tables table_name
               if !ActiveRecord::Base.connection.table_exists? "#{table_name}_propify_fields"
                   ActiveRecord::Base.connection.execute "create table #{table_name}_propify_fields (id integer x INTEGER PRIMARY KEY ASC, name varchar)"
                   ActiveRecord::Base.connection.execute "create table #{table_name}_propify_values (value varchar, #{table_name}_id int, #{table_name}_propify_fields int)"
               end
               
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