Tei Tools
---------

## Installation

Use the standard Radiant extension installation process:

    ./script/extension install git://github.com/jgsmith/radiant-tei-tools.git

To add the default XSLT configuration option:

    rake radiant:extensions:tei_tools:migrate

## Configuration

This extension includes a copy of the TEI Consortium's example XSLT for
transforming TEI into XHTML.  You may change the default XSLT using the
'tei_tools.xslt' config setting.

## Using TEI

We recommend putting your TEI document in its own part.  By default, the
tei:render tag looks for the TEI document in the 'tei' part.

Parameters for the XSLT processor can be placed in a 'tei_params' part.  
These are hierarchical, so you can have this part in a higher-level 
page and just override the parameters needed for a particular TEI document.

### tei:render

This tag transforms the TEI into XHTML and extracts the /html/body content.

The 'xslt' attribute overrides the default XSLT for the transformation.  If
the file is a relative path, it will be relative to the application root.

The 'part' attribute overrides the default part name ('tei') used in the 
transformation.

To render a part called 'xml' with the default XSLT:

    <r:tei:render part="xml" />


### ..._params

This part is not rendered, but is parsed as a simple configuration with
the parameter name and value on a line separated by a colon.  Blank lines
and lines starting with a hash (#) are ignored.

The name of the part is the same as the part being rendered with the
added suffix of '_params'.  For example, if rendering a part named 'tei',
then the parameters are taken from a part named 'tei_params'.

The settings in the ..._params of a child page override the same settings in
a parent page.

The following is an example of what can be in the '..._params' part:

    ## Comments (lines beginning with '#') and blank lines are ignored
    ##
    
    ## Display of <pb> element. Choices are "visible", "active" and "none".
    pagebreakStyle: visible 
    
    ## CSS class for TOC entries
    class_toc: toc
    
    ## CSS class for second-level TOC entries
    class_subtoc: subtoc
    
    ## Depth at which to stop doing a recursive table of contents.
    ## You can have a mini table of contents at the start of each section. The default is only to 
    ## construct a TOC at the top level; a value of -1 here means no subtoc at all.
    subTocDepth: -1
    
    ## Depth to which table of contents is constructed.
    tocDepth: 5
    
    ## Which HTML element to wrap each TOCs entry in.
    tocElement: li
    
    ## Which HTML element to wrap each TOC sections in.
    tocContainerElement: ul
    
    ## CSS class for links derived from <ptr>
    class_ptr: ptr
    
    ## CSS class for links derived from <ref>
    class_ref: ref
    
    ## CSS class for links derived from <xptr>
    class_xptr: xptr
    
    ## CSS class for links derived from <xref>
    class_xref: xref
    
    ## Resolution of images.  This is needed to calculate HTML width and height (in pixels)
    ## from supplied dimensions.
    dpi: 96
    
    ## Display figures
    showFigures: true
    
    ## The difference between TEI div levels and HTML headings.
    ## TEI <div>s are implicitly or explicitly numbered from 0 upwards; this offset is added 
    ## to that number to produce an HTML <Hn> element. So a value of 2 here means that a 
    ## <div0> will generate an <h2>
    divOffset: 2
    
    ## Automatically number paragraphs.
    numberParagraphs: false
    
    ## The style of HTML (Simple, CSS or Table) which creates the layout for generated pages.
    ## The choice is between
    ##   Simple -- A linear presentation is created
    ##   CSS    -- The page is created as a series of nested <div>s which can be arranged using 
    ##             CSS into a multicolumn layout
    ##   Table  -- The page is created as an HTML table
    pageLayout: CSS
    
    ## Directory specification to put before names of graphics files, unless they start with "./"
    graphicsPrefix:
    
    ## Default file suffix for graphics files, if not directly specified
    graphicsSuffix: .png
    
    ## Scaling of imported graphics
    standardScale: 1
    
    ## Name of department within institution
    department: 
    
    ## Name of link to home page of application
    homeLabel: Home
    
    ## Project Home
    homeURL: http://www.example.com/
    
    homeWords: Short Name
    
    ## Institution
    institution: Institution
    
    ## Institution link
    parentURL: http://www.example.org/
    
    ## Name of overall institution
    parentWords: Parent Institution
    
    ## Link to search application
    searchURL: http://www.google.com/
    
    ## The home page of the tei xslt stylesheets
    teixslHome: http://www.tei-c.org/Stylesheets/teic/


[TEI Consortium]: http://www.tei-c.org/
