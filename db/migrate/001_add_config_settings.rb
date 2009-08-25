class AddConfigSettings < ActiveRecord::Migration

  class Config < ActiveRecord::Base; end

  def self.up
    Config.create!(
      :key => 'tei_tools.xslt', 
      :value => 'vendor/extensions/tei_tools/tei-xsl/p5/xhtml/tei.xsl'
    )
  end

  def self.down
    # Not really necessary
  end

end
