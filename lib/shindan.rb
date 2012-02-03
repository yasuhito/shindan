require "rubygems"

require "kconv"
require "mechanize"
require "tempfile"


class Shindan
  URL = "http://shindanmaker.com/163723"
  CSS = "http://shindanmaker.com/css/pc8.css"
  LOGO = "http://shindanmaker.com/img/logo_head.png"
  MIXI_VOICE = "http://shindanmaker.com/img/mixivoice.png"
  HATENA_HAIKU = "http://shindanmaker.com/img/hatenahaiku.png"


  def open name
    system "x-www-browser #{ temp_html shindan( name ) }"
  end


  ##############################################################################
  private
  ##############################################################################


  def shindan name
    agent = Mechanize.new
    agent.get URL
    agent.page.form_with( :name => "enter" ) do | form |
      form[ "u" ] = name.toutf8
      form.click_button
    end
    rewrite agent.page.body
  end


  def rewrite body
    result = body.dup
    result.gsub! /\/css\/pc8\.css/, CSS
    result.gsub! /\/img\/logo_head\.png/, LOGO
    result.gsub! /\/img\/mixivoice\.png/, MIXI_VOICE
    result.gsub! /\/img\/hatenahaiku\.png/, HATENA_HAIKU
  end


  def temp_html body
    t = Tempfile.new( "shindan" )
    t.puts body
    t.close
    html = t.path + ".html"
    FileUtils.mv t.path, html
    html
  end
end
