function New-HTMLTable {
    [alias('Table', 'EmailTable')]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, Position = 0)][ScriptBlock] $HTML,
        [Parameter(Mandatory = $false, Position = 1)][ScriptBlock] $PreContent,
        [Parameter(Mandatory = $false, Position = 2)][ScriptBlock] $PostContent,
        [alias('ArrayOfObjects', 'Object', 'Table')][Array] $DataTable,
        [string[]][ValidateSet('copyHtml5', 'excelHtml5', 'csvHtml5', 'pdfHtml5', 'pageLength', 'searchPanes')] $Buttons = @('copyHtml5', 'excelHtml5', 'csvHtml5', 'pdfHtml5', 'pageLength'),
        [string[]][ValidateSet('numbers', 'simple', 'simple_numbers', 'full', 'full_numbers', 'first_last_numbers')] $PagingStyle = 'full_numbers',
        [int[]]$PagingOptions = @(15, 25, 50, 100),
        [switch]$DisablePaging,
        [switch]$DisableOrdering,
        [switch]$DisableInfo,
        [switch]$HideFooter,
        [alias('DisableButtons')][switch]$HideButtons,
        [switch]$DisableColumnReorder,
        [switch]$DisableProcessing,
        [switch]$DisableResponsiveTable,
        [switch]$DisableSelect,
        [switch]$DisableStateSave,
        [switch]$DisableSearch,
        [switch]$ScrollCollapse,
        [switch]$OrderMulti,
        [switch]$Filtering,
        [ValidateSet('Top', 'Bottom', 'Both')][string]$FilteringLocation = 'Bottom',
        [string[]][ValidateSet('display', 'cell-border', 'compact', 'hover', 'nowrap', 'order-column', 'row-border', 'stripe')] $Style = @('display', 'compact'),
        [switch]$Simplify,
        [string]$TextWhenNoData = 'No data available.',
        [int] $ScreenSizePercent = 0,
        [string[]] $DefaultSortColumn,
        [int[]] $DefaultSortIndex,
        [ValidateSet('Ascending', 'Descending')][string] $DefaultSortOrder = 'Ascending',
        [string[]] $DateTimeSortingFormat,
        [alias('Search')][string]$Find,
        [switch] $InvokeHTMLTags,
        [switch] $DisableNewLine,
        [switch] $ScrollX,
        [switch] $ScrollY,
        [int] $ScrollSizeY = 500,
        [int] $FreezeColumnsLeft,
        [int] $FreezeColumnsRight,
        [switch] $FixedHeader,
        [switch] $FixedFooter,
        [string[]] $ResponsivePriorityOrder,
        [int[]] $ResponsivePriorityOrderIndex,
        [string[]] $PriorityProperties,
        [alias('DataTableName')][string] $DataTableID,
        [switch] $ImmediatelyShowHiddenDetails,
        [alias('RemoveShowButton')][switch] $HideShowButton,
        [switch] $AllProperties,
        [switch] $SkipProperties,
        [switch] $Compare,
        [alias('CompareWithColors')][switch] $HighlightDifferences,
        [int] $First,
        [int] $Last,
        [alias('Replace')][Array] $CompareReplace,
        [alias('RegularExpression')][switch]$SearchRegularExpression,
        [ValidateSet('normal', 'break-all', 'keep-all', 'break-word')][string] $WordBreak = 'normal',
        [switch] $AutoSize,
        [switch] $DisableAutoWidthOptimization,
        [string] $Title,
        [switch] $SearchPane,
        [ValidateSet('top', 'bottom')][string] $SearchPaneLocation = 'top',
        [ValidateSet('HTML', 'JavaScript', 'AjaxJSON')][string] $DataStore,
        [string] $DataStoreID,
        [switch] $Transpose
    )
    if (-not $Script:HTMLSchema.Features) {
        Write-Warning 'New-HTMLTable - Creation of HTML aborted. Most likely New-HTML is missing.'
        Exit
    }
    if ($HideFooter -and $Filtering -and $FilteringLocation -notin @('Both', 'Top')) {
        Write-Warning 'New-HTMLTable - Hiding footer while filtering is requested without specifying FilteringLocation to Top or Both.'
    }
    # There are 3 types of storage: HTML, JavaScript, File
    if ($DataStore -eq '') {
        if ($Script:HTMLSchema.TableOptions.DataStore) {
            # If DataStore is not picked locally, we use global value (assuming it's set)
            $DataStore = $Script:HTMLSchema.TableOptions.DataStore
        } else {
            # No global value, no local value, we set it default
            $DataStore = 'HTML'
        }
    }
    if ($DataStore -eq 'AjaxJSON') {
        if (-not $Script:HTMLSchema['TableOptions']['Folder']) {
            Write-Warning "New-HTMLTable - FilePath wasn't used in New-HTML. It's required for Hosted Solution."
            return
        }
    }
    if ($DataStoreID -and $DataStore -ne 'JavaScript') {
        Write-Warning "New-HTMLTable - Using DataStoreID is only supported if DataStore is JavaScript. It doesn't do anything without it"
    }

    # Theme creator  https://datatables.net/manual/styling/theme-creator
    $ConditionalFormatting = [System.Collections.Generic.List[PSCustomObject]]::new()
    $CustomButtons = [System.Collections.Generic.List[PSCustomObject]]::new()
    $HeaderRows = [System.Collections.Generic.List[PSCustomObject]]::new()
    $HeaderStyle = [System.Collections.Generic.List[PSCustomObject]]::new()
    $HeaderTop = [System.Collections.Generic.List[PSCustomObject]]::new()
    $HeaderResponsiveOperations = [System.Collections.Generic.List[PSCustomObject]]::new()
    $ContentRows = [System.Collections.Generic.List[PSCustomObject]]::new()
    $ContentStyle = [System.Collections.Generic.List[PSCustomObject]]::new()
    $ContentTop = [System.Collections.Generic.List[PSCustomObject]]::new()
    $ContentFormattingInline = [System.Collections.Generic.List[PSCustomObject]]::new()
    $ReplaceCompare = [System.Collections.Generic.List[System.Collections.IDictionary]]::new()
    $TableColumnOptions = [System.Collections.Generic.List[PSCustomObject]]::new()
    $TableEvents = [System.Collections.Generic.List[PSCustomObject]]::new()

    # This will be used to store the colulmnDef option for the datatable
    $ColumnDefinitionList = [System.Collections.Generic.List[PSCustomObject]]::New()
    $RowGrouping = @{ }

    if ($Transpose) {
        # Allows easy conversion from PSCustomObject to Hashtable and vice versa
        $DataTable = Format-TransposeTable -Object $DataTable
    }

    if ($HTML) {
        [Array] $Output = & $HTML

        if ($Output.Count -gt 0) {
            foreach ($Parameters in $Output) {
                if ($Parameters.Type -eq 'TableButtonPDF') {
                    $CustomButtons.Add($Parameters.Output)
                } elseif ($Parameters.Type -eq 'TableButtonCSV') {
                    $CustomButtons.Add($Parameters.Output)
                } elseif ($Parameters.Type -eq 'TableButtonPageLength') {
                    $CustomButtons.Add($Parameters.Output)
                } elseif ($Parameters.Type -eq 'TableButtonExcel') {
                    $CustomButtons.Add($Parameters.Output)
                } elseif ($Parameters.Type -eq 'TableButtonPDF') {
                    $CustomButtons.Add($Parameters.Output)
                } elseif ($Parameters.Type -eq 'TableButtonPrint') {
                    $CustomButtons.Add($Parameters.Output)
                } elseif ($Parameters.Type -eq 'TableButtonCopy') {
                    $CustomButtons.Add($Parameters.Output)
                } elseif ($Parameters.Type -eq 'TableCondition') {
                    $ConditionalFormatting.Add($Parameters.Output)
                } elseif ($Parameters.Type -eq 'TableHeaderMerge') {
                    $HeaderRows.Add($Parameters.Output)
                } elseif ($Parameters.Type -eq 'TableHeaderStyle') {
                    $HeaderStyle.Add($Parameters.Output)
                } elseif ($Parameters.Type -eq 'TableHeaderFullRow') {
                    $HeaderTop.Add($Parameters.Output)
                } elseif ($Parameters.Type -eq 'TableContentMerge') {
                    $ContentRows.Add($Parameters.Output)
                } elseif ($Parameters.Type -eq 'TableContentStyle') {
                    $ContentStyle.Add($Parameters.Output)
                } elseif ($Parameters.Type -eq 'TableContentFullRow') {
                    $ContentTop.Add($Parameters.Output)
                } elseif ($Parameters.Type -eq 'TableConditionInline') {
                    $ContentFormattingInline.Add($Parameters.Output)
                } elseif ($Parameters.Type -eq 'TableHeaderResponsiveOperations') {
                    $HeaderResponsiveOperations.Add($Parameters.Output)
                } elseif ($Parameters.Type -eq 'TableReplaceCompare') {
                    $ReplaceCompare.Add($Parameters.Output)
                } elseif ($Parameters.Type -eq 'TableRowGrouping') {
                    $RowGrouping = $Parameters.Output
                } elseif ($Parameters.Type -eq 'TableColumnOption') {
                    $TableColumnOptions.Add($Parameters.Output)
                } elseif ($Parameters.Type -eq 'TableEvent') {
                    $TableEvents.Add($Parameters.Output)
                }
            }
        }
    }
    # Autosize removes $Width of 100%, which means it will fit the content rather then trying to fill the screen
    if (-not $AutoSize) {
        [string] $Width = '100%'
    }

    # Limit objects count First or Last
    if ($First -or $Last) {
        $DataTable = $DataTable | Select-Object -First $First -Last $Last
    }

    if ($Compare) {
        $Splitter = "`r`n"

        if ($ReplaceCompare) {
            foreach ($R in $CompareReplace) {
                $ReplaceCompare.Add($R)
            }
        }

        $DataTable = Compare-MultipleObjects -Objects $DataTable -Summary -Splitter $Splitter -FormatOutput -AllProperties:$AllProperties -SkipProperties:$SkipProperties -Replace $ReplaceCompare

        if ($HighlightDifferences) {
            $Highlight = for ($i = 0; $i -lt $DataTable.Count; $i++) {
                if ($DataTable[$i].Status -eq $false) {
                    # Different row
                    foreach ($DifferenceColumn in $DataTable[$i].Different) {
                        $DataSame = $DataTable[$i]."$DifferenceColumn-Same" -join $Splitter
                        $DataAdd = $DataTable[$i]."$DifferenceColumn-Add" -join $Splitter
                        $DataRemove = $DataTable[$i]."$DifferenceColumn-Remove" -join $Splitter

                        if ($DataSame -ne '') {
                            $DataSame = "$DataSame$Splitter"
                        }
                        if ($DataAdd -ne '') {
                            $DataAdd = "$DataAdd$Splitter"
                        }
                        if ($DataRemove -ne '') {
                            $DataRemove = "$DataRemove$Splitter"
                        }
                        $Text = New-HTMLText -Text $DataSame, $DataRemove, $DataAdd -Color Black, Red, Blue -TextDecoration none, line-through, none -FontWeight normal, bold, bold
                        New-TableContent -ColumnName "$DifferenceColumn" -RowIndex ($i + 1) -Text "$Text"
                    }
                } else {
                    # Same row
                    # New-TableContent -RowIndex ($i + 1) -BackGroundColor Green -Color White
                }
            }
        }
        $Properties = Select-Properties -Objects $DataTable -ExcludeProperty '*-*', 'Same', 'Different'
        $DataTable = $DataTable | Select-Object -Property $Properties

        if ($HighlightDifferences) {
            foreach ($Parameter in $Highlight.Output) {
                $ContentStyle.Add($Parameter)
            }
        }
    }

    if ($AllProperties) {
        if ($DataTable[0] -is [System.Collections.IDictionary]) {
            # we don't do anything, as dictionaries are displayed in two columns approach
        } else {
            $Properties = Select-Properties -Objects $DataTable -AllProperties:$AllProperties
        }
        if ($Properties -ne '*') {
            $DataTable = $DataTable | Select-Object -Property $Properties
        }
    } else {
        # JavaScript datastore is very picky for the inserted data so columns need to match for each object in array
        # SO if 1st object has 3 columns called X,Y,Z and 2nd object has X,Y,G we need to make sure we force 2nd object to have X,Y,Z (Z will be empty) and skip G
        # If you need need G as well you need to use AllProperties switch
        if ($DataStore -in 'JavaScript', 'AjaxJSON') {
            if ($DataTable[0] -is [System.Collections.IDictionary]) {
                # we don't do anything, as dictionaries are displayed in two columns approach
            } else {
                $Properties = Select-Properties -Objects $DataTable
                if ($Properties -ne '*') {
                    $DataTable = $DataTable | Select-Object -Property $Properties
                }
            }
        }
    }

    # This is more direct way of PriorityProperties that will work also on Scroll and in other circumstances
    if ($PriorityProperties) {
        if ($DataTable.Count -gt 0) {
            $Properties = $DataTable[0].PSObject.Properties.Name
            # $Properties = Select-Properties -Objects $DataTable -AllProperties:$AllProperties
            $RemainingProperties = foreach ($Property in $Properties) {
                if ($PriorityProperties -notcontains $Property) {
                    $Property
                }
            }
            $BoundedProperties = $PriorityProperties + $RemainingProperties
            $DataTable = $DataTable | Select-Object -Property $BoundedProperties
        }
    }

    # This option disable paging if number of elements is less or equal count of elements in DataTable
    $PagingOptions = $PagingOptions | Sort-Object -Unique

    # Building HTML Table / Script
    if (-not $DataTableID) {
        # Only define this if user failed to deliver as per https://github.com/EvotecIT/PSWriteHTML/issues/29
        $DataTableID = "DT-$(Get-RandomStringName -Size 8 -LettersOnly)" # this builds table ID
    }

    $Options = [ordered] @{
        'dom'            = $null
        "searchFade"     = $false
        "colReorder"     = -not $DisableColumnReorder.IsPresent


        # https://datatables.net/examples/basic_init/scroll_y_dynamic.html
        "paging"         = -not $DisablePaging
        "scrollCollapse" = $ScrollCollapse.IsPresent

        <# Paging Type
            numbers - Page number buttons only
            simple - 'Previous' and 'Next' buttons only
            simple_numbers - 'Previous' and 'Next' buttons, plus page numbers
            full - 'First', 'Previous', 'Next' and 'Last' buttons
            full_numbers - 'First', 'Previous', 'Next' and 'Last' buttons, plus page numbers
            first_last_numbers - 'First' and 'Last' buttons, plus page numbers
        #>
        "pagingType"     = $PagingStyle
        "lengthMenu"     = @(
            , @($PagingOptions + (-1))
            , @($PagingOptions + "All")
        )
        "ordering"       = -not $DisableOrdering.IsPresent
        "order"          = @() # this makes sure there's no default ordering upon start (usually it would be 1st column)
        "rowGroup"       = ''
        "info"           = -not $DisableInfo.IsPresent
        "procesing"      = -not $DisableProcessing.IsPresent
        "select"         = -not $DisableSelect.IsPresent
        "searching"      = -not $DisableSearch.IsPresent
        "stateSave"      = -not $DisableStateSave.IsPresent
    }
    # Set DOM
    if ($SearchPane) {
        # it seems DataTablesSearchPanes is conflicting with Diagrams in IE 11, so we only enable it on demand
        $Script:HTMLSchema.Features.DataTablesSearchPanes = $true
        <# DOM Definition: https://datatables.net/reference/option/dom
            l - length changing input control
            f - filtering input
            t - The table!
            i - Table information summary
            p - pagination control
            r - processing display element
            B - Buttons
            S - Select
            F - FadeSeaerch
            P - SearchPanes
        #>
        if ($SearchPaneLocation) {
            $Options['dom'] = 'PBfrtip'
        } else {
            $Options['dom'] = 'BfrtipP'
        }
    } else {
        $Options['dom'] = 'Bfrtip'
    }
    if ($Buttons -contains 'searchPanes') {
        # it seems DataTablesSearchPanes is conflicting with Diagrams in IE 11, so we only enable it on demand
        $Script:HTMLSchema.Features.DataTablesSearchPanes = $true
    }


    # this handles no data in Table - we want table to be minimalistic then
    if ($null -eq $DataTable -or $DataTable.Count -eq 0) {
        #return ''
        $Filtering = $false # setting it to false because it's not nessecary
        $HideFooter = $true
        $DataTable = $TextWhenNoData
    }

    # Prepare data for preprocessing. Convert Hashtable/Ordered Dictionary to their visual representation
    $Table = $null
    if ($null -eq $DataTable[0]) {
        Write-Warning 'New-HTMLTable - First value in DataTable is null. Skipping.'
        return
    } elseif ($DataTable[0] -is [System.Collections.IDictionary]) {
        [Array] $Table = foreach ($_ in $DataTable) {
            $_.GetEnumerator() | Select-Object Name, Value
        }
        $ObjectProperties = 'Name', 'Value'
    } elseif ($DataTable[0].GetType().Name -match 'bool|byte|char|datetime|decimal|double|ExcelHyperLink|float|int|long|sbyte|short|string|timespan|uint|ulong|URI|ushort') {
        [Array] $Table = $DataTable | ForEach-Object { [PSCustomObject]@{ 'Name' = $_ } }
        $ObjectProperties = 'Name'
    } else {
        [Array] $Table = $DataTable
        $ObjectProperties = $DataTable[0].PSObject.Properties.Name
    }

    if ($DataStore -eq 'HTML') {
        #  Standard way to build inline table
        $Table = $Table | ConvertTo-Html -Fragment | Select-Object -SkipLast 1 | Select-Object -Skip 2 # This removes table tags (open/closing)
        [string] $Header = $Table | Select-Object -First 1 # this gets header
        [string[]] $HeaderNames = $Header -replace '</th></tr>' -replace '<tr><th>' -split '</th><th>'
        if ($HeaderNames -eq '*') {
            # HeaderNames normally contain proper header names, however ConvertTo-HTML -Fragment in PowerShell 5.1 incorrectly sets it to *
            # PowerShell 7 works without issues. This is reproducible with [PSCustomObject]@{ 'Name' = 'Test' } | ConvertTo-Html -Fragment
            $Header = $Header.Replace('*', $ObjectProperties)
            $HeaderNames = $ObjectProperties
        }
        # This modifies Table content.
        # It basically goes thru every single row and checks if values to add styles or inline conditional formatting
        # It's heavier then JS, so use when nessecary
        if ($ContentRows.Capacity -gt 0 -or $ContentStyle.Count -gt 0 -or $ContentTop.Count -gt 0 -or $ContentFormattingInline.Count -gt 0) {
            $Table = Add-TableContent -ContentRows $ContentRows -ContentStyle $ContentStyle -ContentTop $ContentTop -ContentFormattingInline $ContentFormattingInline -Table $Table -HeaderNames $HeaderNames
        }
        $Table = $Table | Select-Object -Skip 1 # this gets actuall table content
    } elseif ($DataStore -eq 'AjaxJSON') {
        # this is hosted solution that only works on servers
        # this is a bit different so there's no full html building
        [string] $Header = $Table | ConvertTo-Html -Fragment | Select-Object -Skip 2 -First 1
        [string[]] $HeaderNames = $Header -replace '</th></tr>' -replace '<tr><th>' -split '</th><th>'
        if ($HeaderNames -eq '*') {
            # HeaderNames normally contain proper header names, however ConvertTo-HTML -Fragment in PowerShell 5.1 incorrectly sets it to *
            # PowerShell 7 works without issues. This is reproducible with [PSCustomObject]@{ 'Name' = 'Test' } | ConvertTo-Html -Fragment
            $Header = $Header.Replace('*', $ObjectProperties)
            $HeaderNames = $ObjectProperties
        }
        New-TableServerSide -DataTable $Table -DataTableID $DataTableID -Options $Options -HeaderNames $HeaderNames
        $Table = $null
    } elseif ($DataStore -eq 'JavaScript') {
        # This puts data as JavaScript Data field inline in html
        [string] $Header = $Table | ConvertTo-Html -Fragment | Select-Object -Skip 2 -First 1
        [string[]] $HeaderNames = $Header -replace '</th></tr>' -replace '<tr><th>' -split '</th><th>'
        if ($HeaderNames -eq '*') {
            # HeaderNames normally contain proper header names, however ConvertTo-HTML -Fragment in PowerShell 5.1 incorrectly sets it to *
            # PowerShell 7 works without issues. This is reproducible with [PSCustomObject]@{ 'Name' = 'Test' } | ConvertTo-Html -Fragment
            $Header = $Header.Replace('*', $ObjectProperties)
            $HeaderNames = $ObjectProperties
        }
        New-TableJavaScript -HeaderNames $HeaderNames -Options $Options
        # Due to ConvertTo-Json depth we can't insert data from Table to $Options here.
        # We need to wait and insert it after it's converted to JSON
    }

    # This modifies header adding styles, header rows, or doing some fancy stuff
    $AddedHeader = Add-TableHeader -HeaderRows $HeaderRows -HeaderNames $HeaderNames -HeaderStyle $HeaderStyle -HeaderTop $HeaderTop -HeaderResponsiveOperations $HeaderResponsiveOperations

    if (-not $HideButtons) {
        $Options['buttons'] = @(
            if ($CustomButtons) {
                $CustomButtons
            } else {
                foreach ($button in $Buttons) {
                    if ($button -eq 'pdfHtml5') {
                        $ButtonOutput = [ordered] @{
                            extend      = 'pdfHtml5'
                            pageSize    = 'A3'
                            orientation = 'landscape'
                            title       = $Title
                        }
                    } elseif ($button -eq 'pageLength') {
                        if (-not $DisablePaging -and -not $ScrollY) {
                            $ButtonOutput = @{
                                extend = $button
                            }
                        }
                    } else {
                        $ButtonOutput = [ordered] @{
                            extend = $button
                            title  = $Title
                        }
                    }
                    Remove-EmptyValue -Hashtable $ButtonOutput
                    $ButtonOutput
                }
            }
        )
    } else {
        $Options['buttons'] = @()
    }
    if ($ScrollX) {
        $Options.'scrollX' = $true
        # disabling responsive table because it won't work with ScrollX
        $DisableResponsiveTable = $true
    }
    if ($ScrollY) {
        $Options.'scrollY' = "$($ScrollSizeY)px"
    }

    if ($FreezeColumnsLeft -or $FreezeColumnsRight) {
        $Options.fixedColumns = [ordered] @{ }
        if ($FreezeColumnsLeft) {
            $Options.fixedColumns.leftColumns = $FreezeColumnsLeft
        }
        if ($FreezeColumnsRight) {
            $Options.fixedColumns.rightColumns = $FreezeColumnsRight
        }
    }
    if ($FixedHeader -or $FixedFooter) {
        # Using FixedHeader/FixedFooter won't work with ScrollY.
        $Options.fixedHeader = [ordered] @{ }
        if ($FixedHeader) {
            $Options.fixedHeader.header = $FixedHeader.IsPresent
        }
        if ($FixedFooter) {
            $Options.fixedHeader.footer = $FixedFooter.IsPresent
        }
    }
    #}

    # this was due to: https://github.com/DataTables/DataTablesSrc/issues/143
    if (-not $DisableResponsiveTable) {
        $Options["responsive"] = @{ }
        $Options["responsive"]['details'] = @{ }
        if ($ImmediatelyShowHiddenDetails) {
            $Options["responsive"]['details']['display'] = '$.fn.dataTable.Responsive.display.childRowImmediate'
        }
        if ($HideShowButton) {
            $Options["responsive"]['details']['type'] = 'none' # this makes button invisible
        } else {
            $Options["responsive"]['details']['type'] = 'inline' # this adds a button
        }
    } else {
        # HideSHowButton doesn't work
        # ImmediatelyShowHiddenDetails doesn't work
        # Maybe I should communicate this??
        # Better would be with parametersets but don't want to play now
    }


    if ($OrderMulti) {
        $Options.orderMulti = $OrderMulti.IsPresent
    }
    if ($Find -ne '') {
        $Options.search = @{
            search = $Find
        }
    }

    [int] $RowGroupingColumnID = -1
    if ($RowGrouping.Count -gt 0) {
        if ($RowGrouping.Name) {
            $RowGroupingColumnID = ($HeaderNames).ToLower().IndexOf($RowGrouping.Name.ToLower())
        } else {
            $RowGroupingColumnID = $RowGrouping.ColumnID
        }
        if ($RowGroupingColumnID -ne -1) {
            $ColumnsOrder = , @($RowGroupingColumnID, $RowGrouping.Sorting)
            if ($DefaultSortColumn.Count -gt 0 -or $DefaultSortIndex.Count -gt 0) {
                Write-Warning 'New-HTMLTable - Row grouping sorting overwrites default sorting.'
            }
        } else {
            Write-Warning 'New-HTMLTable - Row grouping disabled. Column name/id not found.'
        }
    } else {
        # Sorting
        if ($DefaultSortOrder -eq 'Ascending') {
            $Sort = 'asc'
        } else {
            $Sort = 'desc'
        }
        if ($DefaultSortColumn.Count -gt 0) {
            $ColumnsOrder = foreach ($Column in $DefaultSortColumn) {
                $DefaultSortingNumber = ($HeaderNames).ToLower().IndexOf($Column.ToLower())
                if ($DefaultSortingNumber -ne - 1) {
                    , @($DefaultSortingNumber, $Sort)
                }
            }

        }
        if ($DefaultSortIndex.Count -gt 0 -and $DefaultSortColumn.Count -eq 0) {
            $ColumnsOrder = foreach ($Column in $DefaultSortIndex) {
                if ($Column -ne - 1) {
                    , @($Column, $Sort)
                }
            }
        }
    }
    if ($ColumnsOrder.Count -gt 0) {
        $Options."order" = @($ColumnsOrder)
        # there seems to be a bug in ordering and colReorder plugin
        # Disabling colReorder
        $Options.colReorder = $false
    }

    # Overwriting table size - screen size in percent. With added Section/Panels it shouldn't be more than 90%
    if ($ScreenSizePercent -gt 0) {
        $Options."scrollY" = "$($ScreenSizePercent)vh"
    }
    if ($null -ne $ConditionalFormatting -and $ConditionalFormatting.Count -gt 0) {
        $Options.createdRow = ''
    }

    if ($ResponsivePriorityOrderIndex -or $ResponsivePriorityOrder) {

        $PriorityOrder = 0

        [Array] $PriorityOrderBinding = @(
            foreach ($_ in $ResponsivePriorityOrder) {
                $Index = [array]::indexof($HeaderNames.ToUpper(), $_.ToUpper())
                if ($Index -ne -1) {
                    [pscustomobject]@{ responsivePriority = 0; targets = $Index }
                }
            }
            foreach ($_ in $ResponsivePriorityOrderIndex) {
                [pscustomobject]@{ responsivePriority = 0; targets = $_ }
            }
        )

        foreach ($_ in $PriorityOrderBinding) {
            $PriorityOrder++
            $_.responsivePriority = $PriorityOrder
            $ColumnDefinitionList.Add($_)
        }
    }

    # The table column options also adds to the columnDefs parameter
    If ($TableColumnOptions.Count -gt 0) {
        foreach ($_ in $TableColumnOptions) {
            $ColumnDefinitionList.Add($_)
        }
    }

    # If we have a column definition list defined, then set the columnDefs option
    If ($ColumnDefinitionList.Count -gt 0) {
        $Options.columnDefs = $ColumnDefinitionList.ToArray()
    }

    If ($DisableAutoWidthOptimization) {
        $Options.autoWidth = $false
    }

    $Options = $Options | ConvertTo-Json -Depth 6

    # cleans up $Options for ImmediatelyShowHiddenDetails
    # Since it's JavaScript inside we're basically removing double quotes from JSON in favor of no quotes at all
    # Before: "display": "$.fn.dataTable.Responsive.display.childRowImmediate"
    # After: "display": $.fn.dataTable.Responsive.display.childRowImmediate
    $Options = $Options -replace '"(\$\.fn\.dataTable\.Responsive\.display\.childRowImmediate)"', '$1'

    if ($DataStore -eq 'JavaScript') {
        # Since we only want first level of data from DataTable we need to do it via string replacement.
        # ConvertTo-Json -Depth 6 from Options above would copy nested objects
        if ($DataStoreID) {
            # We decided we want to separate JS data from the table. This is useful for 2 reason
            # Data is pushed to footer and doesn't take place inside Body
            # Data can be reused in multiple tables for display purposes of same thing but in different table
            $Options = $Options -replace '"markerForDataReplacement"', $DataStoreID
            # We only add data if it isn't added yet
            if (-not $Script:HTMLSchema.CustomFooterJS[$DataStoreID]) {
                $DataToInsert = $Table | ConvertTo-Json -Depth 1 #-Compress
                if ($DataToInsert.StartsWith('[')) {
                    $Script:HTMLSchema.CustomFooterJS[$DataStoreID] = "var $DataStoreID = $DataToInsert;"
                } else {
                    $Script:HTMLSchema.CustomFooterJS[$DataStoreID] = "var $DataStoreID = [$DataToInsert];"
                }
            }
        } else {
            $DataToInsert = $Table | ConvertTo-Json -Depth 1 #-Compress
            if ($DataToInsert.StartsWith('[')) {
                $Options = $Options -replace '"markerForDataReplacement"', $DataToInsert
            } else {
                $Options = $Options -replace '"markerForDataReplacement"', "[$DataToInsert]"
            }
        }
        # we need to reset table to $Null to make sure it's not added as HTML as well
        $Table = $null
    }

    # Process Conditional Formatting. Ugly JS building
    $Options = New-TableConditionalFormatting -Options $Options -ConditionalFormatting $ConditionalFormatting -Header $HeaderNames -DataStore $DataStore
    # Process Row Grouping. Ugly JS building
    if ($RowGroupingColumnID -ne -1) {
        $Options = Convert-TableRowGrouping -Options $Options -RowGroupingColumnID $RowGroupingColumnID
        $RowGroupingTop = Add-TableRowGrouping -DataTableName $DataTableID -Top -Settings $RowGrouping
        $RowGroupingBottom = Add-TableRowGrouping -DataTableName $DataTableID -Bottom -Settings $RowGrouping
    }

    [Array] $Tabs = ($Script:HTMLSchema.TabsHeaders | Where-Object { $_.Current -eq $true })
    if ($Tabs.Count -eq 0) {
        # There are no tabs in use, pretend there is only one Active Tab
        $Tab = @{ Active = $true }
    } else {
        # Get First Tab
        $Tab = $Tabs[0]
    }

    # return data
    if (-not $Simplify) {
        $Script:HTMLSchema.Features.Jquery = $true
        $Script:HTMLSchema.Features.DataTables = $true
        $Script:HTMLSchema.Features.Moment = $true
        if (-not $HideButtons) {
            $Script:HTMLSchema.Features.DataTablesPDF = $true
            $Script:HTMLSchema.Features.DataTablesExcel = $true
        }
        #$Script:HTMLSchema.Features.DataTablesSearchFade = $true

        if ($ScrollX) {
            $TableAttributes = @{ id = $DataTableID; class = "$($Style -join ' ')"; width = $Width }
        } else {
            $TableAttributes = @{ id = $DataTableID; class = "$($Style -join ' ')"; width = $Width }
        }

        # Enable Custom Date fromat sorting
        $SortingFormatDateTime = Add-CustomFormatForDatetimeSorting -DateTimeSortingFormat $DateTimeSortingFormat
        $FilteringOutput = Add-TableFiltering -Filtering $Filtering -FilteringLocation $FilteringLocation -DataTableName $DataTableID -SearchRegularExpression:$SearchRegularExpression
        $FilteringTopCode = $FilteringOutput.FilteringTopCode
        $FilteringBottomCode = $FilteringOutput.FilteringBottomCode
        $LoadSavedState = Add-TableState -DataTableName $DataTableID -Filtering $Filtering -FilteringLocation $FilteringLocation -SavedState (-not $DisableStateSave)
        if ($TableEvents.Count -gt 0) {
            $TableEventsCode = Add-TableEvent -Events $TableEvents -HeaderNames $HeaderNames -DataStore $DataStore
            # this adds required JS script to escape regex when needed
            $Script:HTMLSchema.Features.EscapeRegex = $true
        }

        if ($Tab.Active -eq $true) {
            New-HTMLTag -Tag 'script' {
                @"
                `$(document).ready(function() {
                    $SortingFormatDateTime
                    $RowGroupingTop
                    $LoadSavedState
                    $FilteringTopCode
                    //  Table code
                    var table = `$('#$DataTableID').DataTable(
                        $($Options)
                    );
                    $FilteringBottomCode
                    $RowGroupingBottom
                    $TableEventsCode
                });
"@
            }

        } else {
            [string] $TabName = $Tab.Id
            New-HTMLTag -Tag 'script' {
                @"
                    `$(document).ready(function() {
                        $SortingFormatDateTime
                        $RowGroupingTop
                        `$('.tabs').on('click', 'a', function (event) {
                            if (`$(event.currentTarget).attr("data-id") == "$TabName" && !$.fn.dataTable.isDataTable("#$DataTableID")) {
                                $LoadSavedState
                                $FilteringTopCode
                                //  Table code
                                var table = `$('#$DataTableID').DataTable(
                                    $($Options)
                                );
                                $FilteringBottomCode
                            };
                        });
                        $RowGroupingBottom
                    });
"@
            }
        }
    } else {
        $TableAttributes = @{ class = 'simplify' }
        $Script:HTMLSchema.Features.DataTablesSimplify = $true
    }

    if ($InvokeHTMLTags) {
        # By default HTML tags are displayed, in this case we're converting tags into real tags
        $Table = $Table -replace '&lt;', '<' -replace '&gt;', '>' -replace '&amp;', '&' -replace '&nbsp;', ' ' -replace '&quot;', '"' -replace '&#39;', "'"
    }
    if (-not $DisableNewLine) {
        # Finds new lines and adds HTML TAG BR
        #$Table = $Table -replace '(?m)\s+$', "`r`n<BR>"
        $Table = $Table -replace '(?m)\s+$', "<BR>"
    }

    if ($OtherHTML) {
        $BeforeTableCode = Invoke-Command -ScriptBlock $OtherHTML
    } else {
        $BeforeTableCode = ''
    }

    if ($PreContent) {
        $BeforeTable = Invoke-Command -ScriptBlock $PreContent
    } else {
        $BeforeTable = ''
    }
    if ($PostContent) {
        $AfterTable = Invoke-Command -ScriptBlock $PostContent
    } else {
        $AfterTable = ''
    }

    if ($RowGrouping.Attributes.Count -gt 0) {
        $RowGroupingCSS = ConvertTo-LimitedCSS -ID $DataTableID -ClassName 'tr.dtrg-group td' -Attributes $RowGrouping.Attributes -Group
    } else {
        $RowGroupingCSS = ''
    }
    New-HTMLTag -Tag 'div' -Attributes @{ class = 'flexElement overflowHidden' } -Value {
        $RowGroupingCSS
        $BeforeTableCode
        $BeforeTable
        # Build HTML TABLE

        if ($WordBreak -ne 'normal') {
            New-HTMLTag -Tag 'style' {
                ConvertTo-LimitedCSS -ClassName 'td' -ID $TableAttributes.id -Attributes @{ 'word-break' = $WordBreak }
            }
        }

        New-HTMLTag -Tag 'table' -Attributes $TableAttributes {
            New-HTMLTag -Tag 'thead' {
                if ($AddedHeader) {
                    $AddedHeader
                } else {
                    $Header
                }
            }
            if ($Table) {
                New-HTMLTag -Tag 'tbody' {
                    $Table
                }
            }
            if (-not $HideFooter) {
                New-HTMLTag -Tag 'tfoot' {
                    $Header
                }
            }
        }
        $AfterTable
    }
}
