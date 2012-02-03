require "rubygems"

require "kconv"
require "mechanize"
require "tempfile"


class Shindan
  URL = "http://shindanmaker.com/"


  def initialize shindan_id
    @shindan_id = shindan_id
  end


  def get name
    shindan( name ).search( "div.result" ).inner_text.strip
  end


  def open name
    system "x-www-browser #{ temp_html shindan( name ).body }"
  end


  ##############################################################################
  private
  ##############################################################################


  def css
    "#{ URL }/css/pc8.css"
  end


  def logo
    "#{ URL }/img/logo_head.png"
  end


  def hatena_haiku
    "#{ URL }/img/hatenahaiku.png"
  end


  def mixi_voice
    "#{ URL }/img/mixivoice.png"
  end


  def shindan name
    agent = Mechanize.new
    agent.get "#{ URL }/#{ @shindan_id }"
    agent.page.form_with( :name => "enter" ) do | form |
      form[ "u" ] = name.toutf8
      form.click_button
    end
    agent.page
  end


  def temp_html body
    t = Tempfile.new( "shindan" )
    t.puts rewrite( body )
    t.close
    html = t.path + ".html"
    FileUtils.mv t.path, html
    html
  end


  def rewrite body
    result = body.dup
    result.gsub! /\/css\/pc8\.css/, css
    result.gsub! /\/img\/logo_head\.png/, logo
    result.gsub! /\/img\/mixivoice\.png/, mixi_voice
    result.gsub! /\/img\/hatenahaiku\.png/, hatena_haiku
  end
end
