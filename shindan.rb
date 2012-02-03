#
# Author: Yasuhito Takamiya <yasuhito@gmail.com>
#
# Copyright (C) 2012 Yasuhito Takamiya <yasuhito@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License, version 2, as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#


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


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
