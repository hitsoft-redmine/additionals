# Formater
module Additionals
  module Formatter
    SMILEYS = { 'smiley' => ':-?\)', # :)
                'smiley2' => '=-?\)', # =)
                'laughing' => ':-?D', # :D
                'laughing2' => '[=]-?D', # =D
                'crying' => '[=:][\'*]\(', # :'(
                'sad' => '[=:]-?\(', # :(
                'wink' => ';-?[)D]', # ;)
                'cheeky' => '[=:]-?[Ppb]', # :P
                'shock' => '[=:]-?[Oo0]', # :O
                'annoyed' => '[=:]-?[\\/]', # :/
                'confuse' => '[=:]-?S', # :S
                'straight' => '[=:]-?[\|\]]', # :|
                'embarrassed' => '[=:]-?[Xx]', # :X
                'kiss' => '[=:]-?\*', # :*
                'angel' => '[Oo][=:]-?\)', # O:)
                'evil' => '>[=:;]-?[)(]', # >:)
                'rock' => 'B-?\)', # B)
                'rose' => '@[)\}][-\\/\',;()>\}]*', # @}->-
                'exclamation' => '[\[(]![\])]', # (!)
                'question' => '[\[(]\?[\])]', # (?)
                'check' => '[\[(]\\/[\])]', # (/)
                'success' => '[\[(]v[\])]', # (v)
                'failure' => '[\[(]x[\])]' }.freeze # (x)

    def render_inline_smileys(text)
      return text if text.blank?

      inline_smileys(text)
      text
    end

    def inline_smileys(text)
      SMILEYS.each do |name, regexp|
        text.gsub!(/(\s|^|>|\))(!)?(#{regexp})(?=\W|$|<)/m) do
          leading = Regexp.last_match(1)
          esc = Regexp.last_match(2)
          smiley = Regexp.last_match(3)
          if esc.nil?
            leading + content_tag(:span,
                                  '',
                                  class: "additionals smiley smiley-#{name}",
                                  title: smiley)
          else
            leading + smiley
          end
        end
      end
    end
  end
end
