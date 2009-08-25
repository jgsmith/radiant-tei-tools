require "rexml/document"
require 'xml/xslt'

module TeiTools::Tags
  include Radiant::Taggable

  desc "Place holder"
  tag "tei" do |tag|
    # do we want to calculate the params here?

    tag.expand
  end

  desc "Renders the TEI XML as html suitable for inclusion in an HTML page"
  tag "tei:render" do |tag|
    xslt = XML::XSLT.new()

    xslt_file = tag.attr['xslt']
    if xslt_file.blank?
      xslt_file = Radiant::Config['tei_tools.xslt']
    end

    if not xslt_file =~ /^\//
      xslt_file = RAILS_ROOT + '/' + xslt_file
    end

    part_name = tag.attr['part'] || 'tei'

    page = tag.locals.page
    part = page.parts.select{ |ppp| ppp.name == part_name }.first

    params = { }
      p = page.parts.select{ |ppp| ppp.name == part_name + "_params"}.first
      if !p.nil? && !p.content.blank?
        p.content.split(/[\n\r]+/).delete_if do |l| 
          l =~ /^\s*#/ || !(l =~ /:/) 
        end.each do |l|
          pair = l.split(/:/,2).map{ |b| b.strip }
            pair[1] = "" if pair[1].nil?
            next if pair[0].nil? || pair[0].blank?
          params[pair[0]] = pair[1] if params[pair[0]].nil?
        end
      end

    page_ancestors = page.ancestors
    
    page_ancestors.each do |pp|
      p = pp.parts.select{ |ppp| ppp.name == part_name + "_params"}.first
      if !p.nil? && !p.content.blank?
        p.content.split(/[\n\r]+/).select do |l| 
          !(l.nil? || l =~ /^\s*#/) && l =~ /:/
        end.each do |l|
          if !l.nil? && !l.blank?
            ppp = l.split(/:/,2).map{ |b| b.strip }
            ppp[1] = "" if ppp[1].nil?
            next if ppp[0].nil? || ppp[0].blank?
            params[ppp[0]] = ppp[1] unless params.include?(ppp[0])
          end
        end
      end
    end

    if part.nil? || part.content.blank?
      return '';
    else
      xslt.parameters = params
      xslt.xsl = xslt_file
      xslt.xml = part.content
      out = xslt.serve()
      # now we want to extract the body
      
      doc = REXML::Document.new out
      REXML::XPath.match(doc, '/html/body/*').map { |e| e.to_s }.join('')
    end
  end
end
