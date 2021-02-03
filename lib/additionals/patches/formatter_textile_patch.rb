module Additionals
  module Patches
    module FormatterTextilePatch
      extend ActiveSupport::Concern

      included do
        include Additionals::Formatter

        if Additionals.setting?(:legacy_smiley_support)
          Redmine::WikiFormatting::Textile::Formatter::RULES << :inline_smileys
        end
      end
    end
  end
end
