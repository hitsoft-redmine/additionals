module Additionals
  module Patches
    module FormattingHelperPatch
      def self.included(base)
        base.send(:prepend, InstanceOverwriteMethods)
        base.class_eval do
          unloadable # Send unloadable so it will not be unloaded in development
          if Rails.version < '5.0.0'
            alias_method_chain :heads_for_wiki_formatter, :additionals
          else
            alias_method :heads_for_wiki_formatter_without_additionals, :heads_for_wiki_formatter
            alias_method :heads_for_wiki_formatter, :heads_for_wiki_formatter_with_additionals
          end
        end
      end

      module InstanceOverwriteMethods
        def heads_for_wiki_formatter_with_additionals
          heads_for_wiki_formatter_without_additionals

          unless @heads_for_wiki_additionals_included

            return if @additionals_macro_list

            @additionals_macro_list = AdditionalsMacro.all(filtered: Additionals.setting(:hidden_macros_in_toolbar).to_a,
                                                           only_names: true,
                                                           controller_only: controller_name)

            return if @additionals_macro_list.count.zero?


            content_for :header_tags do
              javascript_include_tag('additionals_macro_button', plugin: 'additionals') +
                  javascript_tag("jsToolBar.prototype.macroList = #{@additionals_macro_list.to_json};")
            end
            @heads_for_wiki_additionals_included = true
          end
        end
      end
    end
  end
end
