module V1
  class ApidocsController < ActionController::Base
    include Swagger::Blocks

    swagger_root do
      key :swagger, '2.0'
      info do
        key :version, '1.0.0'
        key :title, 'Combat API'
        key :description, 'An API that matches Marvel Characters and Battles with them.'
        key :termsOfService, 'AS IS. NO WARRANTY.'
        contact do
          key :name, 'hello@davewoodall.com'
        end
        license do
          key :name, 'MIT'
        end
      end
      key :host, 'combat.fakefarm.com'
      key :basePath, '/v1/combat'
      key :produces, ['application/json']
    end

    # A list of all classes that have swagger_* declarations.
    SWAGGERED_CLASSES = [
      CombatController,
      self,
    ].freeze

    def index
      render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
    end
  end
end