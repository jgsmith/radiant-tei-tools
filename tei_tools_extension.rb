# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class TeiToolsExtension < Radiant::Extension
  version "1.0"
  description "Tags and extensions useful for managing TEI documents"
  url "http://github.com/jgsmith/radiant-tei-tools"
  
  def activate
    Page.send :include, TeiTools::Tags
  end
  
  def deactivate
  end
  
end
