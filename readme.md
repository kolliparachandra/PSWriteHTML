<p align="center">
  <a href="https://dev.azure.com/evotecpl/PSWriteHTML/_build/latest?definitionId=3"><img src="https://dev.azure.com/evotecpl/PSWriteHTML/_apis/build/status/EvotecIT.PSWriteHTML"></a>
  <a href="https://www.powershellgallery.com/packages/PSWriteHTML"><img src="https://img.shields.io/powershellgallery/v/PSWriteHTML.svg"></a>
  <a href="https://www.powershellgallery.com/packages/PSWriteHTML"><img src="https://img.shields.io/powershellgallery/vpre/PSWriteHTML.svg?label=powershell%20gallery%20preview&colorB=yellow"></a>
  <a href="https://github.com/EvotecIT/PSWriteHTML"><img src="https://img.shields.io/github/license/EvotecIT/PSWriteHTML.svg"></a>
</p>

<p align="center">
  <a href="https://www.powershellgallery.com/packages/PSWriteHTML"><img src="https://img.shields.io/powershellgallery/p/PSWriteHTML.svg"></a>
  <a href="https://github.com/EvotecIT/PSWriteHTML"><img src="https://img.shields.io/github/languages/top/evotecit/PSWriteHTML.svg"></a>
  <a href="https://github.com/EvotecIT/PSWriteHTML"><img src="https://img.shields.io/github/languages/code-size/evotecit/PSWriteHTML.svg"></a>
  <a href="https://www.powershellgallery.com/packages/PSWriteHTML"><img src="https://img.shields.io/powershellgallery/dt/PSWriteHTML.svg"></a>
</p>

<p align="center">
  <a href="https://twitter.com/PrzemyslawKlys"><img src="https://img.shields.io/twitter/follow/PrzemyslawKlys.svg?label=Twitter%20%40PrzemyslawKlys&style=social"></a>
  <a href="https://evotec.xyz/hub"><img src="https://img.shields.io/badge/Blog-evotec.xyz-2A6496.svg"></a>
  <a href="https://www.linkedin.com/in/pklys"><img src="https://img.shields.io/badge/LinkedIn-pklys-0077B5.svg?logo=LinkedIn"></a>
</p>

# PSWriteHTML - PowerShell Module

`PSWriteHTML` is fork of [ReportHTML](https://github.com/azurefieldnotes/ReportHTML/) module. I've forked [ReportHTML](https://github.com/azurefieldnotes/ReportHTML/) due to it being outdated and not maintained. I also wanted to address some problems it has and add more features. As it stands `PSWriteHTML` is complete rewrite and  doesn't use same naming convention as [ReportHTML](https://github.com/azurefieldnotes/ReportHTML/) or even same code, therefore you can have both. Keep in mind the approach on building html is much more simplified and I'm adding more and more features.

## How to install

While you can take sources and use it from here, **PSWriteHTML** actually is composed of multiple other of my modules. To get it up and running you will need ***PSSharedGoods**, and **PSSharedGoods** will need **Connectimo** and **PSWriteColor**. While **Connectimo** or **PSWriteColor** aren't needed for **PSWriteHTML**, **PSSharedGoods** uses them for some of the commands and it will fail without them. You can get all that from sources but if you **just want** to use my modules you should use `Install-Module` command. It's available in PowerShell 5.1. As an added bonus when I publish modules to **PowerShellGallery** I remove any junk, minimize modules to a single file which makes them faster to load and use. I really encourage you to use module from PowerShellGallery and treat **GitHub** as highely development version. Since version 0.0.61 when **PSWriteHTML** is published every dependency is baked into **PSWriteHTML**. That means you don't need to download any other modules unless you want to contribute to this project.

### To install

```powershell
Install-Module -Name PSWriteHTML -AllowClobber -Force
```

Force and AllowClobber aren't necessary but they do skip errors in case some appear.

### And to update

```powershell
Update-Module -Name PSWriteHTML
```

That's it. Whenever there's new version you simply run the command and you can enjoy it. Remember, that you may need to close, reopen PowerShell session if you have already used module before updating it.

**The important thing** is if something works for you on production, keep using it till you test the new version on a test computer. I do changes that may not be big, but big enough that auto-update will break your code. For example, small rename to a parameter and your code stops working! Be responsible!

Dependencies: **PSSharedGoods**, **PSWriteColor** and **Connectimo** are only used during development. When published to PSGallery / Releases it's merged release without any dependencies.

## Articles worth reading to understand use cases

- [x] [Meet Statusimo – PowerShell generated Status Page](https://evotec.xyz/meet-statusimo-powershell-generated-status-page/)
- [x] [Meet Dashimo – PowerShell Generated Dashboard](https://evotec.xyz/meet-dashimo-powershell-generated-dashboard/)
- [x] [Dashimo – Easy Table Conditional Formatting and more](https://evotec.xyz/dashimo-easy-table-conditional-formatting-and-more/)
- [x] [Out-HtmlView – HTML alternative to Out-GridView](https://evotec.xyz/out-htmlview-html-alternative-to-out-gridview/)
- [x] [Meet Emailimo – New way to send pretty emails with PowerShell](https://evotec.xyz/meet-emailimo-new-way-to-send-pretty-emails-with-powershell/)
- [x] [All your HTML Tables are belong to us](https://evotec.xyz/all-your-html-tables-are-belong-to-us/)
- [x] [Sending HTML emails with PowerShell and zero HTML knowledge required](https://evotec.xyz/sending-html-emails-with-powershell-and-zero-html-knowledge-required/)
- [x] [Dashimo (PSWriteHTML) – Charting, Icons and few other changes](https://evotec.xyz/dashimo-pswritehtml-charting-icons-and-few-other-changes/)
- [x] [Working with HTML in PowerShell just got better](https://evotec.xyz/working-with-html-in-powershell-just-got-better/)
- [x] [Comparing two or more objects visually in PowerShell (cross-platform)](https://evotec.xyz/comparing-two-or-more-objects-visually-in-powershell-cross-platform/)
- [x] [Easy way to create diagrams using PowerShell and PSWriteHTML](https://evotec.xyz/easy-way-to-create-diagrams-using-powershell-and-pswritehtml/)
- [x] [Nested Tabs, Diagram Updates, Diagram Events, Calendar Object and more in PSWriteHTML](https://evotec.xyz/nested-tabs-diagram-updates-diagram-events-calendar-object-and-more-in-pswritehtml/)
- [x] [Emailimo merged into PSWriteHTML, IE support and no dependencies](https://evotec.xyz/emailimo-merged-into-pswritehtml-ie-support-and-no-dependencies/)
- [x] [Active Directory DHCP Report to HTML or EMAIL with zero HTML knowledge](https://evotec.xyz/active-directory-dhcp-report-to-html-or-email-with-zero-html-knowledge/)

## Changelog

- 0.0.111 - Unreleased
  - Added `New-HTMLOrgChart`
  - Added `New-OrgChartNode`
- 0.0.110 - 2020.09.29
  - Fix for `New-HTMLImage` messed up height with width
- 0.0.109 - 2020.09.28
  - If no author is provided meta is not added
  - `EmailText` `size` parameter supports the usual settings as described below
  - Removed `EmailText` and added it as alias to `New-HTMLText` which does the same thing
  - Renamed `EmailHTML` to `Add-HTML`, added `EmailHTML` as alias - this allows to inline any code wherever it's used
  - Added `EmailImage` as alias to `New-HTMLImage`
  - Added `Inline` switch to `New-HTMLImage (EmailImage)` which embeddes given url/file image directly into HTML
  - Improved `New-HTMLImage/EmailImage`
  - Prevents errors `New-HTMLTable` if null is passed as first element in DataTable (skips processing)
- 0.0.108 - 2020.09.23
  - Added escaping regex for string comparison during `New-TableEvent`
- 0.0.107 - 2020.09.23
  - Fix for Table Redraw/Calendar Redraw when tab switching/section collapsing
- 0.0.106 - 2020.09.23
  - Fix for `New-TableEvent` not working properly for column id different than `1`
  - Improvements to `New-TableEvent` introducing Source/Target columns with Source Column Names support
- 0.0.105 - 2020.09.23
  - Improved `New-HTMLTable` - removed page button if `DisablePaging` or `ScrollY` is selected
  - Updated PSD1 to better version
  - Fix for `New-HTMLTable` always forcing to HTML if not global option was used
- 0.0.104 - 2020.09.14
  - Added `notlike`/`notcontains` operators to `New-TableCondition`
  - Fixed `like/notcontains` operators for JavaScript datasource in `New-TableCondition`
- 0.0.103 - 2020.09.13
  - Fix for wrong custom CSS placement
- 0.0.102 - 2020.09.13
  - **Updates**
  - Fix for `New-DiagramEvent` to work while `FontIcons` are used
  - Some improvements to `New-HTMLPanel` to better positioning Diagrams
  - Added Loading Bar to `New-HTMLDiagram`. You can disable it using `DisableLoader` switch.
- 0.0.101 - 2020.09.12
  - **Updates**
    - [x] Added `Transpose` to `New-HTMLTable`/`Out-HtmlView`
- 0.0.100 - 2020.09.12
  - **Library updates**
    - Update to `Apex Charts` from 3.20.0 to 3.20.1
  - **Updates**
    - [x] Fix long lasting issue with loading `FontIcons` in diagrams. Should be visible now.
    - [x] Support for nested hashtables `ConvertTo-CascadingStyleSheets`
    - [x] Fix/workaround for IE11 issue with section not showing any data, broken in 0.0.99
- 0.0.99 - 2020.09.07
  - **Notes**
    - [x] `UTF8` will be set by default for `HTML`. `Email` will pick content encoding from `HTML`
      - [x] It was already set for `HTML` for `charset` so just making sure it's all the same
    - [x] Encoding parameter for `EmailOption` and `Email` are DEPRECATED
      - [x] Whatever you set there doesn't matter - it will always be set to `UTF8`. From my tests setting it to anything else messes up display in some clients
      - [x] While not really breaking change, just thought I would make sure people are aware
      - [x] The reason is HTML was always `UTF8` and setting it up on transport level to `Unicode` or other encodings would break things
      - [x] In outlook it wouldn't matter as it would fix it, but in other clients such as Thunderbird it would go nuts
  - **Library updates**
    - Update to `vis-network` from 8.2.1 to 8.3.2
  - **New/Non-Breaking**
    - [x] Added aliases for `New-HTMLTableOption`
    - [x] Fixes for Request Configuration for Sections and Panels
    - [x] Fixes meta tags for HTML4/HTML5
    - [x] Addeed **NoClosing** parameter to `New-HTMLTag`
    - [x] Improvements to `Section` Hiding horizontally and vertically
    - [x] Improvements to diagram resizing when section resizes - should be no need to resize diagram anymore
- 0.0.98 - 2020.08.30
  - **New/Non-Breaking**
    - [x] Added `DataStoreID` to `New-HTMLTable` for use with `DataStore = JavaScript`
      - [x] This allows multiple tables to use same data. Useful if you want to present same data in different tables across single HTML file.
    - [x] Fixes for JavaScript datastore and conditional formatting
- 0.0.97 - 2020.08.29
  - **Breaking changes**
    - [x] Diagrams
      - [x] New-DiagramLink
        - [ ] `ArrowsToEnabled` -> `nullable bool` replaced with `switch`
        - [ ] `ArrowsMiddleEnabled` -> `nullable bool` replaced with `switch`
        - [ ] `ArrowsFromEnabled` -> `nullable bool` replaced with `switch`
        - [ ] `ArrowStrikethrough` -> `nullable bool` replaced with `switch`
        - [ ] `Chosen` -> `nullable bool` replaced with `switch`
        - [ ] `FontSize` -> `int` replaced with `object` - check notes in `0.95`
        - [ ] `FontStrokeWidth` -> `int` replaced with `object` - check notes in `0.95`
  - **New/Non-Breaking**
    - [x] New-DiagramNode
      - [ ] Exposed `ArrowsToEnabled`, `ArrowsMiddleEnabled`, `ArrowsFromEnabled`
    - [x] Update to Diagram Height accepting multiple size values
      - [x] This allows for `New-HTMLDiagram -Height 'calc(100vh - 50px)'` which fills whole screen (within section)
      - [x] Or this `New-HTMLDiagram -Height 'calc(100vh - 50px)' -Width '50vw'` although not that useful, as flex fixes most of it
    - [x] Updates `New-DiagramOptionsPhysics` - exposed a bunch of new options plus help
    - [x] Updates `New-DiagramOptionsLayout` - added some help and new options
  - **Updated library**
    - [x] `Vis-network` to 8.2.1
- 0.0.96 - 2020.08.28
  - [x] It seems SearchPanes from DataTables conflict with `New-HTMLDiagram`
    - [x] Separated that library to be added only on demand
- 0.0.95 - 2020.08.27
  - **Notes**
    - I'm reworking CSS model in which PSWriteHTML works allowing for more consistent design and more customization options. This means some breaking changes will happen soon enough.
    - FontSize will be reworked for most commands (as I get to them) to take `[int]` input but also `[string]` input
      - If `[int]` is provided it assumes size given in `px`. If text is provided it takes it as is.
        - If `15` this means `15px`
        - If `15px` this means `15px`
        - If `15pt` this means `15pt`
        - If `'15'` this means `15px` as it will convert to `[int]` first
        - Anything else will be treated as is meaning you know what you are doing
  - **Breaking changes**
    - [x] Default Font Size for everything is `8pt`. This includes:
      - [x] Tabs used to have `15px`. Now by default `8pt`. You will need `New-HTMLTabOption -FontSize '15px'` or `New-HTMLTabOption -FontSize 15` to set default fontsize for Tabs to it's old value (along with other customizations if needed)
      - [x] Inputs for Tables (Filtering) having static `8pt`
  - **Improvements**
    - [x] `New-HTMLMain` - allows customizing font size, font type, background color and text color globally - this will overwrite defaults as described above
    - [x] Fix TempFilePath for `Email` to work correctly on MacOS/Linux - tnx roberttoups [#146](https://github.com/EvotecIT/PSWriteHTML/pull/146)
    - [x] Auto-wrapping of Tabs is enabled - can be disabled via `New-HTMLTabOption`
    - [x] Bunch of options to control wrapping/direction of tabs via `New-HTMLTabOption`
    - [x] Ability to define `RowElements` in `New-HTMLTabOption` to force number of tabs per row
    - [x] Fixed BackgroundColor for `New-HTMLTabOption`
    - [x] Removed `default.css` in favor of native powershell css
    - [x] `New-HTMLTable` warning - `Hiding footer while filtering is requested without specifying FilteringLocation to Top or Both`
    - [x] Fixed broken `Tab` switching in **Internet Explorer 11**
    - [x] Added basic support for `SearchPane` within `New-HTMLTable`
    - [x] Fixed broken `Tables` refresh on `Tabs` when using named `Tables`
    - [x] Fixed `New-HTMLTable`/`Out-HTMLView` with `-AllProperties` displaying wrong properties for IDictionary objects
    - [x] Fixed `New-HTMLTable` properly displaying string/int and other data if passed as single value
    - [x] Fixed `New-HTMLTable` properly display ordered dictionary, array of strings, array of singular objects, PSCustomObject with 1 column
    - [x] Fixed `New-HTMLTable` properly displaying column name as `Name` in PowerShell 5.1 when used with int/string
    - [x] Fixed `New-HTMLText` font size was ignored. Also now supports 15, 15px, 15pt as described in notes.
    - [x] Resolves peformance issues by adding new parameter `DataStore` for `New-HTMLTable` to use with large tables
  - **Added cmdlets**
    - [x] `New-HTMLTableStyle`
    - [x] `New-HTMLTableOption` - added to provide `DataStore` parameter which globally sets required store, may be used for other things in future
    - [x] `New-ChartTimeLine` - added basic support for TimeLine Charts
  - **Renamed cmdlets** (non-breaking change via aliases)
    - [x] `New-HTMLTabOption` -> `New-HTMLTabStyle`
    - [x] `New-HTMLSectionOption` -> `New-HTMLSectionStyle`
  - **Library updates**
    - `DataTables` and all related libraries
    - `JQuery` to 3.5.1
    - `ApexCharts` updated from 3.18.2 to 3.20
    - `FontAwesome` updated from 5.13 to 5.14
- 0.0.94 - 2020.08.18
  - Public
    - [x] Added `New-TableEvent` for `New-HTMLTable` **experimental**
- 0.0.93 - 2020.08.16
  - Public
    - Fixes
      - [x] Fix for `New-HTMLTabOption` switch "-SelectorColor" sets the color permanently [#128](https://github.com/EvotecIT/PSWriteHTML/issues/128)
      - [x] Fix for `InvokeHTMLTags` in `New-HTMLTable` - replacement of (`&amp;` to `&`) and (`&nbsp;` to `<space>`)
        - [x] Before it would try to change from `'&amp;nbsp;` to `<space>` which is wrong. Hopefully nothing will broken after that
    - Improvements
      - [x] Choosing colors should be easier (wildcard added before and after)
      - [x] Make it optional for `New-HTMLTab` to force TextTransform (uses global)
      - [x] `New-HTMLSection`/`New-HTMLPanel` were updated to support additional options
    - New
      - [x] Added `ConvertTo-CascadingStyleSheets` - converts hashtable into CSS
      - [x] Added `New-HTMLSectionOption` - **experimental**
      - [x] Added `New-HTMLPanelOption` - **experimental**
      - [x] Added `AnchorName` for sections and panels
      - [x] Added `New-HTMLAnchor/New-HTMLLink`
  - Internal
    - [x] Support interally for `Custom Header CSS`, `Custom Footer CSS`
- 0.0.92 - 2020.08.08
  - Fixes `New-HierarchicalTreeNode` not recognized in latest modules [#141](https://github.com/EvotecIT/PSWriteHTML/issues/141)
- 0.0.91 - 2020.08.03
  - Refreshing release - fix for Remove-EmptyValue
- 0.0.90 - 2020.07.27
  - Added `New-TableColumnOption` for `New-HTMLTable` - tnx zsoch [#138](https://github.com/EvotecIT/PSWriteHTML/pull/138)
  - Removed dead/old `FullCalendar` js code
  - Updated `JustGage` to 1.3.5
- 0.0.89 - 2020.07.23
  - Fix for Tooltips in FullCalendar 5.1 - tnx smasterson [#137](https://github.com/EvotecIT/PSWriteHTML/pull/137)
- 0.0.88 - 2020.07.21
  - Updated `New-HTMLCalendar` with more options for `InitialView` parameter - tnx smasterson [#135](https://github.com/EvotecIT/PSWriteHTML/pull/135)
- 0.0.87 - 2020.07.20
  - Updated FullCalendar library to 5.1 from 4.3
  - `New-HTMLCalendar`- removed `plugins` parameter (no longer required)
  - `New-HTMLCalendar` - removed `WeekNumbersWithinDays` (no longer required)
  - `New-HTMLCalendar` - added `InitialView` parameter
  - Fixed Tabs switching with multiple tables on each tab fails [#134](https://github.com/EvotecIT/PSWriteHTML/issues/134)
  - Fixed Tabs switching with calendars [#133](https://github.com/EvotecIT/PSWriteHTML/issues/133)
- 0.0.86 - 2020.07.14
  - Fix for missing `Get-TemporaryDirectory` during merge - damn nested ASTTokens
  - Module is now signed (hopefully that doesn't break anything)
- 0.0.85 - 2020.06.27
  - Update `New-HTMLSpanStyle` with some protection for errors
  - Fix from PSSCriptAnalyzer - The Variable 'Event' is an automatic variable that is built into PowerShell, assigning to it might have undesired side effects. If assignment is not by design, please use a different name.
- 0.0.84 - 2020.06.11
  - `Colors` autocompleter should be now a bit smarter
  - Added `Online` to `EmailBody`
  - `EmailBody` can be used separatly now to generate HTML in case someone would like to use it with their own Send Email
    - Say .. using `Mailozaurr` (new PowerShell module)
  - `Email` has `OutputHTML` parameter which can send email but also output HTML for whatever reason

- 0.0.83 - 2020.05.27
  - Fix for `New-HTMLMain` and junk code showing up in HTML

- 0.0.82 - 2020.04.23
  - `New-HTMLTable` added ability to define Title which will be used as filename when exporting
    - If no Title is defined title is used from `New-HTML`
    - If no Title is provided name of button will be used (default)
  - `New-TableButtonXXX` also have `Title` field which allows different naming for buttons

- 0.0.81 - 2020.04.18
  - `New-HTMLDiagram` keeps expanding without height bug fixed ([#113](https://github.com/EvotecIT/PSWriteHTML/issues/113)) with huge help from Thomaash

- 0.0.80 - 2020.04.13
  - **DEPRECATED**: `UseJavaScriptLinks` and `UseCssLinks` for `New-HTML`. Use `Online` switch instead.
  - Updated Vis.JS to 7.5.2
  - Updated FontAwesome to 5.13 and hopefully made it available offline
  - Updated ApexCharts to 3.18.1
  - Changed default for Email to Offline. Use `Online` switch to minimize content.
  - `New-HTMLTable` -HideButtons added [#114](https://github.com/EvotecIT/PSWriteHTML/issues/114)

- 0.0.79 - 2020.03.24
  - Typo fixes for Suppress
  - Added `AutoSize` parameter for `New-HTMLTable`/`EmailTable`
  - `Out-HtmlView` switched to `Offline` mode by default. Added `Online` switch.
    - Considering same approach to New-HTML (by default it's offline, but naming convention `UseJavaScriptLinks` and `UseCssLinks` is a bit weird)

- 0.0.77 - 2020.03.04
  - Updates to New-HTMLStatusItem [#111](https://github.com/EvotecIT/PSWriteHTML/pull/111) - tnx jimmy58663
    - Support for FontAwesome, More colors and Hex.
  - Fixes to New-HTMLHeading color property being empty

- 0.0.76 - 2020.02.07
  - Added -PreventShowHTML to Out-HtmlView for quick use with Path.

- 0.0.75 - 2020.02.07
  - Improvment for very long words in New-HTMLTable and New-TableContent using WordBreak parameter - issue [#107](https://github.com/EvotecIT/PSWriteHTML/issues/107)

- 0.0.74 - 2020.01.26
  - Improvements to speed Targetted DataTable recalc for tabs and sections - pull [#105](https://github.com/EvotecIT/PSWriteHTML/pull/105) / issue [#101](https://github.com/EvotecIT/PSWriteHTML/issues/101) - tnx opustecnica

- 0.0.73 - 2020.01.20
  - Fix for Out-HtmlView erroring out if Table was not given (or null)

- 0.0.72 - 2020.01.13
  - Removed unused CSS
  - Fix for Out-HtmlView buttons missing PageLength
  - Added FavIcon to New-HTML [#99](https://github.com/EvotecIT/PSWriteHTML/issues/99) / [#102](https://github.com/EvotecIT/PSWriteHTML/pull/102) - tnx xlrod
  - Updates to New-TableConditionalFormatting for IE 11 support [#100](https://github.com/EvotecIT/PSWriteHTML/pull/100) - tnx opustecnica
  - Updates to Search via RegularExpressions [#100](https://github.com/EvotecIT/PSWriteHTML/pull/100) - tnx opustecnica

- 0.0.71 - 2019.12.26
  - Fix for New-HTMLSection -JustifyContent missing in Invisible
  - Added option to disable the "Properties" row in `Out-HTMLView -SkipProperties` for **Compare** feature (tnx **AdrianDeller**) ([#91](https://github.com/EvotecIT/PSWriteHTML/issues/91) / [#96](https://github.com/EvotecIT/PSWriteHTML/pull/96))
  - Added New-HTMLHeader, New-HTMLMain, New-HTMLFooter

- 0.0.70 - 2019.12.19
  - Library update
    - JQuery to 3.4.1
    - ApexCharts to 3.11.1, and set a static version (instead of latest)
  - Addeed New-HTMLTree, New-TreeNode (basic preview)
  - Added New-HTMLHeader, New-HTMLFooter, New-HTMLMain allowing adding content before Tabs or after all content. ([#74](https://github.com/EvotecIT/PSWriteHTML/issues/74))

- 0.0.69 - 2019.12.10
  - Fix for EmailList [#90](https://github.com/EvotecIT/PSWriteHTML/pull/90) - tnx natosullivan
  - Added New-HTMLGage, New-GageSector

- 0.0.68 - 2019.12.07
  - Library update
    - Vis-Network to 6.4.6
  - Diagrams now work in Internet Explorer (yay!)
  - Add Tab border customization and Tab header background color (tnx xlrod!) [#87](https://github.com/EvotecIT/PSWriteHTML/pull/87)
    - [x] New-HTMLTabOption -SlimTabs -SelectorColor Blue **-BorderRadius 25px** **-BorderBackgroundColor LightBlue**
  - Added Tests so basic stuff is tested for regression (it's very basic)
  - Added alias for New-TableConditon (TableCondition)

- 0.0.67 - 2019.11.26
  - Save-HTML improvment to save to temp file if saving fails (tnx xlrod!) ([#81](https://github.com/EvotecIT/PSWriteHTML/issues/81) / [#86](https://github.com/EvotecIT/PSWriteHTML/pull/86))
  - Fix for New-HTMLTable (Convert-ImagesToBinary) on PS 6/7

- 0.0.66 - 2019.11.25
  - Added JustifyContent to New-HTMLSection (thx xlrod!) ([#79](https://github.com/EvotecIT/PSWriteHTML/issues/79) / [#85](https://github.com/EvotecIT/PSWriteHTML/pull/85))

- 0.0.65 - 2019.11.23
  - Fix for Hashtable/OrderedDictionary display in New-HTMLTable/Out-HTMLView

- 0.0.64 - 2019.11.21
  - Added TextTransform for New-HTMLTab (thx xlrod!)

- 0.0.63 - 2019.11.17
  - Fix for WhatIf in Email affecting other places. It should only affect sending emails.

- 0.0.62 - 2019.11.12
  - IE doesn't require approving running scripts anymore! (tnx orzfly)

- 0.0.61 - 2019.11.11
  - New colors (tnx Ferdi), along with ability to use #HEX as color codes
  - Emailimo integrated into PSWriteHTML
  - PSSharedGoods is no longer dependency
    - The way it works is that during development it still is dependency, but during publish it gets merged into one package using PSPublishModule

- 0.0.60 - 2019.11.05
  - Fix for IE 11 support of collapsable sections
  - Fix for nested, invisible sections not working properly
- 0.0.59 - 2019.10.29
  - Library update
    - DataTables upgrade to Nightly (1.10.21-dev) due to broken Table Conditioning. Works with IE as well.
- 0.0.58 - 2019.10.28
  - Library update
    - Vis-Network to 6.3.0 (known issue - IE not working)
    - DataTables downgrade to 1.10.12 for IE to work
  - Fix for IE 11 support of Tabs
  - Fix for IE 11 support of Tables (Out-HTMLView/New-HTMLTable)
  - Fix for Section that starts as Collapsed [#47](https://github.com/EvotecIT/PSWriteHTML/issues/47)
    - It's a heavy fix, meaning it can have perf impact on display - may need changes
  - Added New-TableRowGrouping
    - Allows grouping within New-HTMLTable
- 0.0.57 - 2019.10.13 - [Blog post about release](https://evotec.xyz/nested-tabs-diagram-updates-diagram-events-calendar-object-and-more-in-pswritehtml/)
  - Changes to Tabs
    - Fix for missing comma in Tabs
    - Fix for Tab Selector Color not being applied after changing to Nested Tabs
    - Fix for Tab Selector not being Active by default
  - Changes to Tables
    - Updated Table Row size to 20px from 27px
  - Renamed New-HTMLTable*commands to New-Table* to better reflect what they deliver (and those don't deliver HTML)
    - Old commands still available as aliases
  - Added **Calendar**
    - Added New-HTMLCalendar
    - Added New-CalendarEvent
  - Added **HierarchicalTreeView** - very basic implementation. Not sure it will stick as Diagrams have that option as well **Requires feedback**
    - Added New-HTMLHierarchicalTreeView
    - Added New-HierarchicalTreeNode
  - Changes to **Diagrams**
    - Updated Visjs to 6.1.1 (local version), linked version is always newest
    - Added New-DiagramEvent for linking Tables with Diagrams
    - Fix for Diagram Size
    - Fix for using diagram defaults (smaller size), should work better now

- 0.0.55 - 2019.09.29
  - Fix for Underlined space when using -Collapsable [#51](https://github.com/EvotecIT/PSWriteHTML/issues/51) - Thanks Tuxhedoh
  - Fix for Stacked Charts [#59](https://github.com/EvotecIT/PSWriteHTML/issues/59) - Thanks for reporting colin-hall
  - Fix for Section -Invisible switch
  - Fix for Section impacting charts positioning
  - Added BackgroundImage,BackgroundImageSize for New-HTMLDiagram (doesn't work for Export)
  - Added Nested Tabs

- 0.0.54 - 2019.09.29 - [Blog Post about release](https://evotec.xyz/easy-way-to-create-diagrams-using-powershell-and-pswritehtml/)
  - **Support for Diagrams**
  - Font Awesome update to 5.11.2
  - Enlighter updated to 3.0
  - **Dashimo** integrated to **PSWriteHTML** as aliases

- 0.0.53 - 2019.09.19
  - Bugfix chart inverse colors [#42](https://github.com/EvotecIT/PSWriteHTML/issues/42) - Thanks Ferdi Weiner

- 0.0.52 - 2019.09.07
  - Library updates:
    - ApexCharts update 3.8.5
  - [x] New-HTMLChart
    - [x] Removed Positioning parameter
    - [x] Added New-ChartPie
    - [x] Added New-ChartRadial
    - [x] Added New-ChartDonut
    - [x] Added few parameters to New-HTMLChart

- 0.0.51 - 2019.09.05
  - [x] New-HTMLCode
    - [x] Added some formatting of whitespaces for code

- 0.0.50 - 2019.08.30
  - [x] Add-TableContent
    - [ ] Fix for a typo on LE (tnx gregwold)

- 0.0.49 - 2019.08.25 - [Blog post about release](https://evotec.xyz/comparing-two-or-more-objects-visually-in-powershell-cross-platform/)
  - [x] Save-HTML
    - [ ] Moved some warnings to Verbose
    - [ ] Fixed weird message
  - [x] New-HTMLTable, Out-HTMLView
    - [ ] Added AllProperties switch
    - [ ] Added Compare/Replacements

- 0.0.48 - 2019.08.11
  - I don't know. Got confused what was changed :-p

- 0.0.47 - 2019.08.04
  - [x] Fix for LOGO in PowerShell Core
  - [x] New-HTMLTable
    - [x] Added ImmediatelyShowHiddenDetails switch - Responsive has the ability to display the details that it has hidden in a variety of different ways. Its default is to allow the end user to toggle the the display by clicking on a row and showing the information in a DataTables child row. At times it can be useful not to require end user interaction to display the hidden data in a responsive manner, which can be done with the childRowImmediate display type.
  - [x] Fix for New-HTML wrong positioning in certain conditions - bug introduced in 0.0.46
  - [x] Fix for Table Simplify with margins

- 0.0.46 - 2019.08.04 - [Blog post about release](https://evotec.xyz/working-with-html-in-powershell-just-got-better/)
  - [x] New-HTMLMessage - Removed as not ready, useless
  - [x] New-HTMLTable
    - [ ] Disable Paging when amount of objects to display is lower then PagingOptions
    - [ ] Added DataTableID for special use cases
  - [x] New-HTMLTableContent - Added with plenty of new features
  - [ ] New HTMLTableConditionalFormatting - Added inline parameter

- 0.0.45 - 2019.07.09
  - [x] New-HTMLTable
    - [ ] Added $PriorityProperties parameter - it works also on ScrollX and other types of places contrary to ResponsivePriorityProperties which only works on Responsive Table
    - [ ] It was moved from Out-HtmlView
  - [X] Out-HTMLView
    - [ ] Updated with all features from New-HTMLTable as it's useful to use it for fast output

- 0.0.44 - 2019.07.08
  - [x] New-HTMLTable
    - [ ] Small improvement when no data provided
  - [x] New-HTMLTableCondition
    - [ ] Supports contains now - PR by Adam Cook (codamok)
  - [ ] Removed ColorSchemes - removal of ReportHTML old code

- 0.0.43 - 2019.07.01
  - [x] New-HTMLTable
    - [ ] Fix for ScrollX with low amount of columns

- 0.0.42 - 2019.07.01
  - [x] New-HTMLTableConditionalFormatting
    - [ ] Fix for Powershell Core, where conditional formatting wouldn't show up

- 0.0.41 - 2019.06.30
  - [x] New-HTMLTableHeader - removing need for AddRow switch
    - [ ] If used with only Title it will assume AddRow
    - [ ] If used with Names it will assume merging
    - [ ] If used with Names without Title it will assume styling
    - [ ] Left AddRow for compatibility reasons, may remove it in future

- 0.0.40 - 2019.06.29 - [Blog post about release](https://evotec.xyz/all-your-html-tables-are-belong-to-us/)
  - [x] New-HTMLTable features
    - [x] FixedHeader/FixedFooter options
    - [x] Scrolling
      - ScrollX,
      - ScrollY, ScrollSizeY
      - FreezeColumnsLeft, FreezeColumnsRight
    - [x] ResponsivePriorityOrder, ResponsivePriorityOrderIndex
  - [x] New-HTMLTableHeader - **new command**
    - [x] Merging header, styling header, adding header row

- 0.0.39 - 2019.06.20
  - Fix for DefaultSortColumn
  - Fix for DefaultSortOrder when set to descending

- 0.0.38 - 2019.06.17 - [Blog post about release](http://evotec.xyz/dashimo-pswritehtml-charting-icons-and-few-other-changes)
  - Added support for Bar Charts/Line Charts
  - Added support for icons in tabs
  - Added support for controlling tabs
  - Fixes for tables in multiple places
  - Ability to control buttons behavior
  - Many many more, it's a big release

- 0.0.34 - 2019.06.02
  - Fix for New-HTMLListItem to support multiple Texts

- 0.0.33 - 2019.05.28
  - New-HTMLTable - Sorting ordered for DateTime - PR by Ferdi Weiner (ferwe)
  - Removed New-HTMLChart temporary as it will be rebuilt

## Advantages over ReportHTML

- complete rewrite
- faster report building (from 20+ seconds to 0-2 seconds)
- updated libraries
- bunch of different, new features
- easier building HTML

## Credits

[Matthew Quickenden](https://www.linkedin.com/in/matthewquickenden/) ([@lucidqdreams](https://github.com/lucidqdreams)) - author of  ReportHTML - without him this wouldn't be possible.

## Projects using PSWriteHTML (to give you ideas what you can do)

- [Statusimo](https://github.com/EvotecIT/Statusimo) is a PowerShell module that is able to generate a Status Page entirely from PowerShell.
- [Dashimo](https://github.com/EvotecIT/Dashimo) is a PowerShell module that makes generating Dashboards, nice looking HTML, a breeze.
- [Emailimo](https://github.com/EvotecIT/Emailimo) is a PowerShell module that makes writting nice looking HTML emails, easy!
- [Out-HTMLView](https://evotec.xyz/out-htmlview-html-alternative-to-out-gridview/) is a PowerShell cross-platform command alternative to Out-GridView

![Out-HTMLView](https://evotec.xyz/wp-content/uploads/2019/04/Out-HtmlView.gif)

Following external libaries and frameworks are in use. They make `PSWriteHTML` what it is now. This list is dynamic and doesn't cover everything yet.

For colors you can visit this [online page](https://evotec.xyz/wp-content/uploads/2019/05/Example-Colors.html).

## 3rd Party Libraries

**PSWriteHTML** uses some 3rd party libraries to deliver it's functionality. It requires those. There are two ways to use it

- With links to CSS/JS which makes code cleaner and easy to see what is happening
- With code inline in HTML which makes HTML much bigger

Below you can find some of 3rd party libraries being used.

### External JS Framework - DataTables

Following JS Framework is intergrated as part of this module. It's responsible for building Tables

- [x] Downloaded from <https://datatables.net/download/>

![DataTables Example](https://evotec.xyz/wp-content/uploads/2019/03/img_5c9fe366e4906.png)

- [x] Styling Framework:
  - [x] DataTables' default styling.v1.10.18
- [x] Selected Packages:
  - [x] jQuery 3 DataTables requires jQuery. Don't select either version if you already have it.v3.3.1
  - [x] Enhance HTML tables with advanced interaction controls.v1.10.18
- [x] Extensions:
  - [x] AutoFill Excel-like click and drag copying and filling of data.v2.3.2
  - [x] Buttons A common framework for user interaction buttons.v1.5.4
  - [x] Column visibility End user buttons to control column visibility.v1.5.4
  - [ ] Flash export Create Excel, PDF, CSV files and copy data from the table. For legacy browsers.v1.5.4
  - [x] HTML5 export Copy to clipboard and create Excel, PDF and CSV files from the table's data.v1.5.4
    - [ ] JSZip Required for the Excel HTML5 export button.v2.5.0
    - [ ] pdfmake Required for the PDF HTML5 export button.v0.1.36
  - [x] Print view Button that will display a printable view of the table.v1.5.4
  - [x] ColReorder Click-and-drag column reordering.v1.5.0
  - [x] FixedColumns Fix one or more columns to the left or right of a scrolling table.v3.2.5
  - [x] FixedHeader Sticky header and / or footer for the table.v3.1.4
  - [x] KeyTable Keyboard navigation of cells in a table, just like a spreadsheet.v2.5.0
  - [x] Responsive Dynamically show and hide columns based on the browser size.v2.2.2
  - [x] RowGroup Show similar data grouped together by a custom data point.v1.1.0
  - [x] RowReorder Click-and-drag reordering of rows.v1.2.4
  - [x] Scroller Virtual rendering of a scrolling table for large data sets.v1.5.0
  - [x] Select Adds row, column and cell selection abilities to a table.v1.2.6

JSZip and PDFMake are not downloaded as part of this package. They fail to import properly hence they are not bundled as one minified version.

- [x] Extensions:
  - [x] Downloaded from <https://github.com/Stuk/jszip> (3.1.5)
    - [x] JSZip Required for the Excel HTML5 export button.v2.5.0
  - [x] DataTables Package <https://datatables.net/download/> but with separate file
    - [x] pdfmake Required for the PDF HTML5 export button.v0.1.36
  - [x] ChartJS Package - <https://github.com/chartjs/Chart.js/releases>
    - [x] ChartJS - version 2.7.3 (required for charts)

### External JS Framework -EnlighterJS (Mozilla Public License Version 2.0 LICENSE)

**PSWriteHTML** provides built-in EnlighterJS JavaScript. It's responsible for building Code Blocks

![EnlighterJS Example](https://evotec.xyz/wp-content/uploads/2019/03/img_5c9fea1322df8.png)

This allows for **code blocks** support. Currently it uses Release Candidate version as it's first version to support **PowerShell highlighting** and many additional languages. It will be updated to new version

- [x] Downloaded from <https://github.com/EnlighterJS/EnlighterJS>

#### Following languages are supported for New-HTMLCodeBlock

- [x] **Assembly** (assembly, asm)
- [x] **AVR Assembly** (avrassembly, avrasm)
- [x] **C/C++** (c,cpp, c++)
- [x] **C#** (csharp)
- [x] **CSS** (css)
- [x] **Cython** (cython)
- [x] **CordPro** (cordpro)
- [x] **diff** (diff)
- [x] **Dockerfile** (docker, dockerfile)
- [x] **Generic** (generic, standard) - default highlighting scheme
- [x] **Groovy** (groovy)
- [x] **Go** (go, golang)
- [x] **HTML** (html)
- [x] **Ini** (ini, conf)
- [x] **Java** (java)
- [x] **Javascript** (js, javascript, jquery, mootools, ext.js)
- [x] **JSON** (json)
- [x] **Kotlin** (kotlin)
- [x] **LESS** (less)
- [x] **LUA** (lua)
- [x] **Markdown** (gfm, md, markdown)
- [x] **Matlab/Octave** (octave, matlab)
- [x] **NSIS** (nsis)
- [x] **PHP** (php)
- [x] **Powerhsell** (powershell)
- [x] **Prolog** (prolog)
- [x] **Python** (py, python)
- [x] **RAW** (raw) - raw code without highlighting with EnlighterJS container styles!
- [x] **Ruby** (ruby)
- [x] **Rust** (rust)
- [x] **SCSS** (scss, sass)
- [x] **Shellscript** (shell, bash)
- [x] **SQL** (sql)
- [x] **Squirrel** (squirrel)
- [x] **Swift** (swift)
- [x] **Typescript** (typescript)
- [x] **VHDL** (vhdl)
- [x] **VisualBasic** (visualbasic, vb)
- [x] **XML** (xml)
- [x] **YAML** (yaml)

#### Following themes are supported for New-HTMLCodeBlock

- [x] **Enlighter** (enlighter, standard) - Enlighter`s default Theme
- [x] **Classic** (classic) - SyntaxHighlighter inspired
- [x] **Bootstrap** (bootstrap4) - Bootstrap 4 inpired themes, high contrast
- [x] **Beyond** (beyond) - BeyondTechnology Theme
- [x] **Godzilla** (godzilla) - A MDN inspired Theme
- [x] **Eclipse** (eclipse) - Eclipse inspired
- [x] **MooTwo** (mootwo) - Inspired by the MooTools Website
- [x] **Droide** (droide) - Modern, minimalistic
- [x] **Minimal** (minimal) - Bright, High contrast
- [x] **Atomic** (atomic) - Dark, Colorful
- [x] **Dracula** (dracula) - Dark, using official [draculatheme](https://draculatheme.com/) colorscheme
- [x] **Rowhammer** (rowhammer) - Light, Transparent, divided rows

### External JS Framework - VIS Network (MIT LICENSE)

- [x] Downloaded from <https://github.com/visjs/vis-network>
