!! Created by: Optio DesignStudio Version 7.8.30

!! NODES: on
!! RANGES: on

!! Name: cu3404
!! Created: 7/7/2004
!! Updated: 5/25/2023

DOCUMENT "cu3404"
    ACCEPTS pagenum, output_dev, print_dest
    LOAD "~fun\ODUtils77.fun"
    // Beginning of Code Before
    //SET TRACE FILE "~errors\error.log"
    //SET TRACE MASK TRACEMASK("ALL")
    // End of Code Before
    SET INPUT "cu4504"
    LET globals::__FirstPass = TRUE
    LET globals::__CleanConditionNextPagePart1=FALSE
    SET SEQUENCE "PrimaryInput", "Part1Condition", "Part1", "PartPass"
    CALL "__InitWorksheets"
    PROCESS PARTS 
    LET globals::__LastPass = TRUE
    PROCESS "Part1Condition"
    PROCESS "Part1"
END DOCUMENT 

PART "PrimaryInput"
    LET globals::__InputIndex = 0
    CLEAN WORKSHEET "PrimaryInputWS"
    SEARCH WORKSHEET "PrimaryInputWS"
    SET WORKSHEET "PrimaryInputWS"
    // Beginning of Code Before
    SET TRACE FILE "~errors\error.log"
    SET TRACE MASK TRACEMASK("ALL")
    // End of Code Before
    MAP "Text Data Datamap"
    // Beginning of Code After
    CLOSE "cu3404"
    // End of Code After
    IGNORE WORKSHEET "PrimaryInputWS"
END PART 

PART "PartPass"
    LET globals::__FirstPass = FALSE
END PART 

PART "Part1Condition"
    IF globals::__CleanConditionNextPagePart1 THEN 
        LET __NumInstances = NODECOUNT(Part1ConditionWS::Condition,"Header")
        FOR __Counter = 1 TO __NumInstances - 1
            DESTROY Part1ConditionWS::Condition.Header{1}
        END FOR 
        LET globals::__CleanConditionNextPagePart1 = FALSE
        LET Part1ConditionWS::__PageCount = 1
    END IF 
    LET Part1ConditionWS::Condition.Header{0} == PrimaryInputWS::PrimaryInput.Header
    LET Part1ConditionWS::__PageCount = Part1ConditionWS::__PageCount + 1
END PART 

PART "Part1"
    SEARCH WORKSHEET "Part1ConditionWS"
    IF globals::__FirstPass THEN 
        LET __Part1Condition1 = FALSE
        LET __Part1Condition1CP = ( output_dev = "printer" )    // Printer
        LET __Part1Condition2 = FALSE
        LET __Part1Condition2CP = ( output_dev = "PDF" )    // Pdf
        LET __Part1Condition3 = FALSE
        LET __Part1Condition3CP = ( output_dev = "Email" )    // Email
        LET __Part1Condition4 = FALSE
        LET __Part1Condition4CP = ( output_dev = "PCL" )    // Pcl
        LET __Part1Condition5Else = FALSE
        LET __Part1Condition5ElseCP = NOT (__Part1Condition1CP OR __Part1Condition2CP OR __Part1Condition3CP OR __Part1Condition4CP)
    ELSE 
        LET __Part1Condition1 = ( output_dev = "printer" )    // Printer
        LET __Part1Condition1CP = ( output_dev = "printer" )    // Printer
        LET __Part1Condition2 = ( output_dev = "PDF" )    // Pdf
        LET __Part1Condition2CP = ( output_dev = "PDF" )    // Pdf
        LET __Part1Condition3 = ( output_dev = "Email" )    // Email
        LET __Part1Condition3CP = ( output_dev = "Email" )    // Email
        LET __Part1Condition4 = ( output_dev = "PCL" )    // Pcl
        LET __Part1Condition4CP = ( output_dev = "PCL" )    // Pcl
        LET __Part1Condition5Else = NOT (__Part1Condition1 OR __Part1Condition2 OR __Part1Condition3 OR __Part1Condition4)
        LET __Part1Condition5ElseCP = NOT (__Part1Condition1CP OR __Part1Condition2CP OR __Part1Condition3CP OR __Part1Condition4CP)
    END IF 
    IF globals::__FirstPass THEN 
        LET __Part1L1_Break = FALSE
    ELSE 
        LET __Part1L1_Break = TRUE
    END IF 
    IF globals::__FirstPass THEN 
        LET __Part1L2_Break = FALSE
    ELSE 
        LET __Part1L2_Break = TRUE
    END IF 
    IF globals::__FirstPass THEN 
        LET __Part1L3_Break = FALSE
    ELSE 
        LET __Part1L3_Break = TRUE
    END IF 
    IF globals::__FirstPass THEN 
        LET __Part1L4_Break = FALSE
    ELSE 
        LET __Part1L4_Break = TRUE
    END IF 
    IF globals::__FirstPass THEN 
        LET __Part1L5_Break = FALSE
    ELSE 
        LET __Part1L5_Break = TRUE
    END IF 
    IF globals::__FirstPass THEN 
        LET __Part1L6_Break = FALSE
    ELSE 
        LET __Part1L6_Break = TRUE
    END IF 
    IF __Part1Condition1 THEN     //    Printer
        LET __Part1Dest = "Laser Printer"
        LET __FrequencyCollate = FALSE
        SEARCH WORKSHEET "PrimaryInputWS"
        SEARCH WORKSHEET "Part1L1WS"
        LET __CurrentWorksheet = "Part1L1WS"
        IF __Part1L1_Break THEN 
            LET __LastPageNumber = 0
            CALL "__InitAndCreateSegmentMappingWithRegions"
            IF @@TotalPages = 0 AND (__Sections.Count > 0 OR __RegionMapped) THEN 
                LET @@TotalPages = 1
            END IF 
            LET __SegmentCounter = 1
            LET __SegmentCounter2 = 1
            FOR @@Page = 1 TO @@TotalPages
                LET @@StartRepeating = 0
                LET @@EndRepeating = 0
                IF @@TotalPages = 1 THEN 
                    LET __PageType = "SINGLE"
                ELSE 
                        IF @@Page = 1 THEN 
                            LET __PageType = "FIRST"
                        ELSE 
                            IF @@Page <> @@TotalPages THEN 
                                LET __PageType = "MIDDLE"
                            ELSE 
                                LET __PageType = "LAST"
                            END IF 
                        END IF 
                END IF 
                IF __PageType = "SINGLE" THEN 
                    LET @@StartRepeating = __OutSectionStartLineSingle[__SegmentNum[1]]
                ELIF __PageType = "FIRST" THEN 
                    LET @@StartRepeating = __OutSectionStartLineFirst[__SegmentNum[1]]
                ELIF __PageType = "MIDDLE" THEN 
                    LET @@StartRepeating = __OutSectionStartLineMiddle[__SegmentNum[1]]
                ELSE 
                    LET @@StartRepeating = __OutSectionStartLineLast[__SegmentNum[1]]
                END IF 
                LET __SegmentLengthTmp = 0
                WHILE __SegmentCounter2 <= __SegmentCount AND __SegmentLastPageNum[__SegmentCounter2] <= @@Page
                    IF __SegmentLastPageNum[__SegmentCounter2] = @@Page THEN 
                        LET __SegmentLengthTmp = __SegmentLengthTmp + __SegmentLength[__SegmentCounter2]
                    END IF 
                    LET __SegmentCounter2 = __SegmentCounter2 + 1
                END WHILE 
                LET @@EndRepeating = @@StartRepeating + __SegmentLengthTmp
                LET __SegmentLengthTmp = 0
                    LET __SegmentCounter2 = __SegmentCounter2 - 1
                LET @@HeightRepeating = @@EndRepeating - @@StartRepeating
                LET __LayoutDuplex = "LONGEDGE"
                IF @@Page = 1 THEN 
                    LET __LayoutSurface = "FRONT"
                ELSE 
                    LET __LayoutSurface = "EITHER"
                END IF 
                LET __LayoutFeeder = "Lower"
                LET __LayoutPaper = ""
                LET __LayoutLayout = ""
                LET __LayoutStacker = ""
                LET __LayoutMacro = ""
                LET __LayoutMacrosMin = 0
                LET __LayoutMacrosMax = 0
                IF __Part1L1__SegmentCounter < 1 THEN 
                    LET __Part1L1__SegmentCounter = 1
                END IF 
                LET __SegmentCounter = __Part1L1__SegmentCounter
                DRAW "cu3404_p1"
                LET __Part1L1__SegmentCounter = __SegmentCounter
                LET globals::__ProducedOutput = TRUE
        IF NOT __CleanConditionNextPage THEN 
            LET __CleanConditionNextPage = __Part1L1_Break
        END IF 
            END FOR 
        END IF 
        IGNORE WORKSHEET "Part1L1WS"
        SEARCH WORKSHEET "PrimaryInputWS"
        SEARCH WORKSHEET "Part1L2WS"
        LET __CurrentWorksheet = "Part1L2WS"
        IF __Part1L2_Break THEN 
            LET __LastPageNumber = 0
            CALL "__InitAndCreateSegmentMappingWithRegions"
            IF @@TotalPages = 0 AND (__Sections.Count > 0 OR __RegionMapped) THEN 
                LET @@TotalPages = 1
            END IF 
            LET __SegmentCounter = 1
            LET __SegmentCounter2 = 1
            FOR @@Page = 1 TO @@TotalPages
                LET @@StartRepeating = 0
                LET @@EndRepeating = 0
                IF @@TotalPages = 1 THEN 
                    LET __PageType = "SINGLE"
                ELSE 
                        IF @@Page = 1 THEN 
                            LET __PageType = "FIRST"
                        ELSE 
                            IF @@Page <> @@TotalPages THEN 
                                LET __PageType = "MIDDLE"
                            ELSE 
                                LET __PageType = "LAST"
                            END IF 
                        END IF 
                END IF 
                IF __PageType = "SINGLE" THEN 
                    LET @@StartRepeating = __OutSectionStartLineSingle[__SegmentNum[1]]
                ELIF __PageType = "FIRST" THEN 
                    LET @@StartRepeating = __OutSectionStartLineFirst[__SegmentNum[1]]
                ELIF __PageType = "MIDDLE" THEN 
                    LET @@StartRepeating = __OutSectionStartLineMiddle[__SegmentNum[1]]
                ELSE 
                    LET @@StartRepeating = __OutSectionStartLineLast[__SegmentNum[1]]
                END IF 
                LET __SegmentLengthTmp = 0
                WHILE __SegmentCounter2 <= __SegmentCount AND __SegmentLastPageNum[__SegmentCounter2] <= @@Page
                    IF __SegmentLastPageNum[__SegmentCounter2] = @@Page THEN 
                        LET __SegmentLengthTmp = __SegmentLengthTmp + __SegmentLength[__SegmentCounter2]
                    END IF 
                    LET __SegmentCounter2 = __SegmentCounter2 + 1
                END WHILE 
                LET @@EndRepeating = @@StartRepeating + __SegmentLengthTmp
                LET __SegmentLengthTmp = 0
                    LET __SegmentCounter2 = __SegmentCounter2 - 1
                LET @@HeightRepeating = @@EndRepeating - @@StartRepeating
                LET __LayoutDuplex = "LONGEDGE"
                IF @@Page = 1 THEN 
                    LET __LayoutSurface = "BACK"
                ELSE 
                    LET __LayoutSurface = "EITHER"
                END IF 
                LET __LayoutFeeder = ""
                LET __LayoutPaper = ""
                LET __LayoutLayout = ""
                LET __LayoutStacker = ""
                LET __LayoutMacro = ""
                LET __LayoutMacrosMin = 0
                LET __LayoutMacrosMax = 0
                IF __Part1L2__SegmentCounter < 1 THEN 
                    LET __Part1L2__SegmentCounter = 1
                END IF 
                LET __SegmentCounter = __Part1L2__SegmentCounter
                DRAW "cu3404_p2"
                LET __Part1L2__SegmentCounter = __SegmentCounter
                LET globals::__ProducedOutput = TRUE
        IF NOT __CleanConditionNextPage THEN 
            LET __CleanConditionNextPage = __Part1L2_Break
        END IF 
            END FOR 
        END IF 
        IGNORE WORKSHEET "Part1L2WS"
    ELIF __Part1Condition2 THEN     //    Pdf
        LET __Part1Dest = "Pdf"
        LET __Part1DestFile = "print_dest"
        LET __OutputRows = 66
        LET __FrequencyCollate = FALSE
        SEARCH WORKSHEET "PrimaryInputWS"
        SEARCH WORKSHEET "Part1L3WS"
        LET __CurrentWorksheet = "Part1L3WS"
        IF __Part1L3_Break THEN 
            LET __LastPageNumber = 0
            CALL "__InitAndCreateSegmentMappingWithRegions"
            IF @@TotalPages = 0 AND (__Sections.Count > 0 OR __RegionMapped) THEN 
                LET @@TotalPages = 1
            END IF 
            LET __SegmentCounter = 1
            LET __SegmentCounter2 = 1
            FOR @@Page = 1 TO @@TotalPages
                LET @@StartRepeating = 0
                LET @@EndRepeating = 0
                IF @@TotalPages = 1 THEN 
                    LET __PageType = "SINGLE"
                ELSE 
                        IF @@Page = 1 THEN 
                            LET __PageType = "FIRST"
                        ELSE 
                            IF @@Page <> @@TotalPages THEN 
                                LET __PageType = "MIDDLE"
                            ELSE 
                                LET __PageType = "LAST"
                            END IF 
                        END IF 
                END IF 
                IF __PageType = "SINGLE" THEN 
                    LET @@StartRepeating = __OutSectionStartLineSingle[__SegmentNum[1]]
                ELIF __PageType = "FIRST" THEN 
                    LET @@StartRepeating = __OutSectionStartLineFirst[__SegmentNum[1]]
                ELIF __PageType = "MIDDLE" THEN 
                    LET @@StartRepeating = __OutSectionStartLineMiddle[__SegmentNum[1]]
                ELSE 
                    LET @@StartRepeating = __OutSectionStartLineLast[__SegmentNum[1]]
                END IF 
                LET __SegmentLengthTmp = 0
                WHILE __SegmentCounter2 <= __SegmentCount AND __SegmentLastPageNum[__SegmentCounter2] <= @@Page
                    IF __SegmentLastPageNum[__SegmentCounter2] = @@Page THEN 
                        LET __SegmentLengthTmp = __SegmentLengthTmp + __SegmentLength[__SegmentCounter2]
                    END IF 
                    LET __SegmentCounter2 = __SegmentCounter2 + 1
                END WHILE 
                LET @@EndRepeating = @@StartRepeating + __SegmentLengthTmp
                LET __SegmentLengthTmp = 0
                    LET __SegmentCounter2 = __SegmentCounter2 - 1
                LET @@HeightRepeating = @@EndRepeating - @@StartRepeating
                LET __LayoutDuplex = "Off"
                LET __LayoutSurface = ""
                LET __LayoutFeeder = ""
                LET __LayoutPaper = ""
                LET __LayoutLayout = ""
                LET __LayoutStacker = ""
                LET __LayoutMacro = ""
                LET __LayoutMacrosMin = 0
                LET __LayoutMacrosMax = 0
                IF __Part1L3__SegmentCounter < 1 THEN 
                    LET __Part1L3__SegmentCounter = 1
                END IF 
                LET __SegmentCounter = __Part1L3__SegmentCounter
                DRAW "shell2"
                LET __Part1L3__SegmentCounter = __SegmentCounter
                LET globals::__ProducedOutput = TRUE
        IF NOT __CleanConditionNextPage THEN 
            LET __CleanConditionNextPage = __Part1L3_Break
        END IF 
            END FOR 
        END IF 
        IGNORE WORKSHEET "Part1L3WS"
    ELIF __Part1Condition3 THEN     //    Email
        LET __Part1Dest = "Email"
        LET __OutputRows = 66
        LET __FrequencyCollate = FALSE
        SEARCH WORKSHEET "PrimaryInputWS"
        SEARCH WORKSHEET "Part1L4WS"
        LET __CurrentWorksheet = "Part1L4WS"
        IF __Part1L4_Break THEN 
            LET __LastPageNumber = 0
            CALL "__InitAndCreateSegmentMappingWithRegions"
            IF @@TotalPages = 0 AND (__Sections.Count > 0 OR __RegionMapped) THEN 
                LET @@TotalPages = 1
            END IF 
            LET __SegmentCounter = 1
            LET __SegmentCounter2 = 1
            FOR @@Page = 1 TO @@TotalPages
                LET @@StartRepeating = 0
                LET @@EndRepeating = 0
                IF @@TotalPages = 1 THEN 
                    LET __PageType = "SINGLE"
                ELSE 
                        IF @@Page = 1 THEN 
                            LET __PageType = "FIRST"
                        ELSE 
                            IF @@Page <> @@TotalPages THEN 
                                LET __PageType = "MIDDLE"
                            ELSE 
                                LET __PageType = "LAST"
                            END IF 
                        END IF 
                END IF 
                IF __PageType = "SINGLE" THEN 
                    LET @@StartRepeating = __OutSectionStartLineSingle[__SegmentNum[1]]
                ELIF __PageType = "FIRST" THEN 
                    LET @@StartRepeating = __OutSectionStartLineFirst[__SegmentNum[1]]
                ELIF __PageType = "MIDDLE" THEN 
                    LET @@StartRepeating = __OutSectionStartLineMiddle[__SegmentNum[1]]
                ELSE 
                    LET @@StartRepeating = __OutSectionStartLineLast[__SegmentNum[1]]
                END IF 
                LET __SegmentLengthTmp = 0
                WHILE __SegmentCounter2 <= __SegmentCount AND __SegmentLastPageNum[__SegmentCounter2] <= @@Page
                    IF __SegmentLastPageNum[__SegmentCounter2] = @@Page THEN 
                        LET __SegmentLengthTmp = __SegmentLengthTmp + __SegmentLength[__SegmentCounter2]
                    END IF 
                    LET __SegmentCounter2 = __SegmentCounter2 + 1
                END WHILE 
                LET @@EndRepeating = @@StartRepeating + __SegmentLengthTmp
                LET __SegmentLengthTmp = 0
                    LET __SegmentCounter2 = __SegmentCounter2 - 1
                LET @@HeightRepeating = @@EndRepeating - @@StartRepeating
                LET __LayoutDuplex = "LONGEDGE"
                IF @@Page = 1 THEN 
                    LET __LayoutSurface = "FRONT"
                ELSE 
                    LET __LayoutSurface = "EITHER"
                END IF 
                LET __LayoutFeeder = ""
                LET __LayoutPaper = ""
                LET __LayoutLayout = ""
                LET __LayoutStacker = ""
                LET __LayoutMacro = ""
                LET __LayoutMacrosMin = 0
                LET __LayoutMacrosMax = 0
                IF __Part1L4__SegmentCounter < 1 THEN 
                    LET __Part1L4__SegmentCounter = 1
                END IF 
                LET __SegmentCounter = __Part1L4__SegmentCounter
                DRAW "cu3404_p1"
                LET __Part1L4__SegmentCounter = __SegmentCounter
                LET globals::__ProducedOutput = TRUE
        IF NOT __CleanConditionNextPage THEN 
            LET __CleanConditionNextPage = __Part1L4_Break
        END IF 
            END FOR 
            IF __Part1Dest = "Email" THEN 
            END IF 
        END IF 
        IGNORE WORKSHEET "Part1L4WS"
    ELIF __Part1Condition4 THEN     //    Pcl
        LET __Part1Dest = "Pcl"
        LET __Part1DestFile = ""
        LET __OutputRows = 66
        LET __FrequencyCollate = FALSE
        SEARCH WORKSHEET "PrimaryInputWS"
        SEARCH WORKSHEET "Part1L5WS"
        LET __CurrentWorksheet = "Part1L5WS"
        IF __Part1L5_Break THEN 
            LET __LastPageNumber = 0
            CALL "__InitAndCreateSegmentMappingWithRegions"
            IF @@TotalPages = 0 AND (__Sections.Count > 0 OR __RegionMapped) THEN 
                LET @@TotalPages = 1
            END IF 
            LET __SegmentCounter = 1
            LET __SegmentCounter2 = 1
            FOR @@Page = 1 TO @@TotalPages
                LET @@StartRepeating = 0
                LET @@EndRepeating = 0
                IF @@TotalPages = 1 THEN 
                    LET __PageType = "SINGLE"
                ELSE 
                        IF @@Page = 1 THEN 
                            LET __PageType = "FIRST"
                        ELSE 
                            IF @@Page <> @@TotalPages THEN 
                                LET __PageType = "MIDDLE"
                            ELSE 
                                LET __PageType = "LAST"
                            END IF 
                        END IF 
                END IF 
                IF __PageType = "SINGLE" THEN 
                    LET @@StartRepeating = __OutSectionStartLineSingle[__SegmentNum[1]]
                ELIF __PageType = "FIRST" THEN 
                    LET @@StartRepeating = __OutSectionStartLineFirst[__SegmentNum[1]]
                ELIF __PageType = "MIDDLE" THEN 
                    LET @@StartRepeating = __OutSectionStartLineMiddle[__SegmentNum[1]]
                ELSE 
                    LET @@StartRepeating = __OutSectionStartLineLast[__SegmentNum[1]]
                END IF 
                LET __SegmentLengthTmp = 0
                WHILE __SegmentCounter2 <= __SegmentCount AND __SegmentLastPageNum[__SegmentCounter2] <= @@Page
                    IF __SegmentLastPageNum[__SegmentCounter2] = @@Page THEN 
                        LET __SegmentLengthTmp = __SegmentLengthTmp + __SegmentLength[__SegmentCounter2]
                    END IF 
                    LET __SegmentCounter2 = __SegmentCounter2 + 1
                END WHILE 
                LET @@EndRepeating = @@StartRepeating + __SegmentLengthTmp
                LET __SegmentLengthTmp = 0
                    LET __SegmentCounter2 = __SegmentCounter2 - 1
                LET @@HeightRepeating = @@EndRepeating - @@StartRepeating
                LET __LayoutDuplex = "LONGEDGE"
                IF @@Page = 1 THEN 
                    LET __LayoutSurface = "FRONT"
                ELSE 
                    LET __LayoutSurface = "EITHER"
                END IF 
                LET __LayoutFeeder = ""
                LET __LayoutPaper = ""
                LET __LayoutLayout = ""
                LET __LayoutStacker = ""
                LET __LayoutMacro = ""
                LET __LayoutMacrosMin = 0
                LET __LayoutMacrosMax = 0
                IF __Part1L5__SegmentCounter < 1 THEN 
                    LET __Part1L5__SegmentCounter = 1
                END IF 
                LET __SegmentCounter = __Part1L5__SegmentCounter
                DRAW "cu3404_p1"
                LET __Part1L5__SegmentCounter = __SegmentCounter
                LET globals::__ProducedOutput = TRUE
        IF NOT __CleanConditionNextPage THEN 
            LET __CleanConditionNextPage = __Part1L5_Break
        END IF 
            END FOR 
            IF __Part1Dest = "Email" THEN 
            END IF 
        END IF 
        IGNORE WORKSHEET "Part1L5WS"
    ELIF __Part1Condition5Else THEN 
        LET __Part1Dest = "Laser Printer2"
        LET __FrequencyCollate = FALSE
        SEARCH WORKSHEET "PrimaryInputWS"
        SEARCH WORKSHEET "Part1L6WS"
        LET __CurrentWorksheet = "Part1L6WS"
        IF __Part1L6_Break THEN 
            LET __LastPageNumber = 0
            CALL "__InitAndCreateSegmentMappingWithRegions"
            IF @@TotalPages = 0 AND (__Sections.Count > 0 OR __RegionMapped) THEN 
                LET @@TotalPages = 1
            END IF 
            LET __SegmentCounter = 1
            LET __SegmentCounter2 = 1
            FOR @@Page = 1 TO @@TotalPages
                LET @@StartRepeating = 0
                LET @@EndRepeating = 0
                IF @@TotalPages = 1 THEN 
                    LET __PageType = "SINGLE"
                ELSE 
                        IF @@Page = 1 THEN 
                            LET __PageType = "FIRST"
                        ELSE 
                            IF @@Page <> @@TotalPages THEN 
                                LET __PageType = "MIDDLE"
                            ELSE 
                                LET __PageType = "LAST"
                            END IF 
                        END IF 
                END IF 
                IF __PageType = "SINGLE" THEN 
                    LET @@StartRepeating = __OutSectionStartLineSingle[__SegmentNum[1]]
                ELIF __PageType = "FIRST" THEN 
                    LET @@StartRepeating = __OutSectionStartLineFirst[__SegmentNum[1]]
                ELIF __PageType = "MIDDLE" THEN 
                    LET @@StartRepeating = __OutSectionStartLineMiddle[__SegmentNum[1]]
                ELSE 
                    LET @@StartRepeating = __OutSectionStartLineLast[__SegmentNum[1]]
                END IF 
                LET __SegmentLengthTmp = 0
                WHILE __SegmentCounter2 <= __SegmentCount AND __SegmentLastPageNum[__SegmentCounter2] <= @@Page
                    IF __SegmentLastPageNum[__SegmentCounter2] = @@Page THEN 
                        LET __SegmentLengthTmp = __SegmentLengthTmp + __SegmentLength[__SegmentCounter2]
                    END IF 
                    LET __SegmentCounter2 = __SegmentCounter2 + 1
                END WHILE 
                LET @@EndRepeating = @@StartRepeating + __SegmentLengthTmp
                LET __SegmentLengthTmp = 0
                    LET __SegmentCounter2 = __SegmentCounter2 - 1
                LET @@HeightRepeating = @@EndRepeating - @@StartRepeating
                LET __LayoutDuplex = "Off"
                LET __LayoutSurface = ""
                LET __LayoutFeeder = ""
                LET __LayoutPaper = ""
                LET __LayoutLayout = ""
                LET __LayoutStacker = ""
                LET __LayoutMacro = ""
                LET __LayoutMacrosMin = 0
                LET __LayoutMacrosMax = 0
                IF __Part1L6__SegmentCounter < 1 THEN 
                    LET __Part1L6__SegmentCounter = 1
                END IF 
                LET __SegmentCounter = __Part1L6__SegmentCounter
                DRAW "no print"
                    WHEN PrimaryInput.Header.dec_page_num = 999999
                LET __Part1L6__SegmentCounter = __SegmentCounter
                LET globals::__ProducedOutput = TRUE
        IF NOT __CleanConditionNextPage THEN 
            LET __CleanConditionNextPage = __Part1L6_Break
        END IF 
            END FOR 
            IF __Part1Dest = "Email" THEN 
            END IF 
        END IF 
        IGNORE WORKSHEET "Part1L6WS"
    ELSE 
        IF NOT globals::__FirstPass THEN 
            WARNING "The If Condition 'If Condition' did not match any conditions, and a default branch was not specified."
            LET globals::__CleanConditionNextPagePart1 = TRUE
        END IF 
    END IF 
    IF __Part1Dest = "Laser Printer" THEN 
        IF globals::__LastPass THEN 
            CLOSE OUTPUT 
        END IF 
    END IF 
    IF __Part1Dest = "Pdf" THEN 
        IF globals::__LastPass THEN 
            CLOSE OUTPUT 
        END IF 
    END IF 
    IF __Part1Dest = "Email" THEN 
        IF globals::__LastPass THEN 
            CLOSE OUTPUT 
        END IF 
    END IF 
    IF __Part1Dest = "Pcl" THEN 
        IF globals::__LastPass THEN 
            CLOSE OUTPUT 
        END IF 
    END IF 
    IF __Part1Dest = "Laser Printer2" THEN 
        IF globals::__LastPass THEN 
            CLOSE OUTPUT 
        END IF 
    END IF 
IF (Part1L1WS::__CleanConditionNextPage AND Part1L2WS::__CleanConditionNextPage) OR (Part1L3WS::__CleanConditionNextPage) OR (Part1L4WS::__CleanConditionNextPage) OR (Part1L5WS::__CleanConditionNextPage) OR (Part1L6WS::__CleanConditionNextPage) OR globals::__CleanConditionNextPagePart1 OR globals::__FirstPass THEN 

    IF __Part1Condition1CP THEN     //    Printer
        LET __Part1Dest = "Laser Printer"
                LET __CurrentWorksheet = "Part1L1WS"
                    LET __CurrentWorksheet = "Part1L2WS"
    ELIF __Part1Condition2CP THEN     //    Pdf
        LET __Part1Dest = "Pdf"
        LET __Part1DestFile = "print_dest"
                LET __CurrentWorksheet = "Part1L3WS"
    ELIF __Part1Condition3CP THEN     //    Email
        LET __Part1Dest = "Email"
                LET __CurrentWorksheet = "Part1L4WS"
    ELIF __Part1Condition4CP THEN     //    Pcl
        LET __Part1Dest = "Pcl"
        LET __Part1DestFile = ""
                LET __CurrentWorksheet = "Part1L5WS"
    ELIF __Part1Condition5ElseCP THEN 
        LET __Part1Dest = "Laser Printer2"
                LET __CurrentWorksheet = "Part1L6WS"
    END IF 
END IF 
    IF __Part1L1_Break THEN 
        CLEAN WORKSHEET "Part1L1WS"
        LET Part1L1WS::__RegionCount = 0
        LET Part1L1WS::__InstanceCount = 0
    END IF 
    IF NOT globals::__LastPass THEN 
        SEARCH WORKSHEET "Part1L1WS"
        SET WORKSHEET "Part1L1WS"
        CALL "__AppendInputDataToPart1L1WS"
        IGNORE WORKSHEET "Part1L1WS"
    END IF 
    IF __CurrentWorksheet = "Part1L1WS" THEN 
        SEARCH WORKSHEET "Part1L1WS"
        IF __Part1Dest <> "" THEN 
            IF __Part1DestFile <> "" THEN 
                LET __Part1DestFileValue = VALUE(__Part1DestFile)
            ELSE 
                LET __Part1DestFileValue = ""
            END IF 
            IF __FrequencyCollate = FALSE AND globals::__FirstPass THEN 
                IF __FrequencyCollate = FALSE AND __Part1DestFileValue <> "" THEN 
                    ALTER CHANNEL __Part1Dest FILE __Part1DestFileValue
                END IF 
            END IF 
            IF __FrequencyCollate = FALSE OR globals::__FirstPass THEN 
                SET OUTPUT __Part1Dest
            END IF 
        END IF 
        IGNORE WORKSHEET "Part1L1WS"
    END IF 
    IF __Part1L2_Break THEN 
        CLEAN WORKSHEET "Part1L2WS"
        LET Part1L2WS::__RegionCount = 0
        LET Part1L2WS::__InstanceCount = 0
    END IF 
    IF NOT globals::__LastPass THEN 
        SEARCH WORKSHEET "Part1L2WS"
        SET WORKSHEET "Part1L2WS"
        CALL "__AppendInputDataToPart1L2WS"
        IGNORE WORKSHEET "Part1L2WS"
    END IF 
    IF __CurrentWorksheet = "Part1L2WS" THEN 
        SEARCH WORKSHEET "Part1L2WS"
        IF __Part1Dest <> "" THEN 
            IF __Part1DestFile <> "" THEN 
                LET __Part1DestFileValue = VALUE(__Part1DestFile)
            ELSE 
                LET __Part1DestFileValue = ""
            END IF 
            IF __FrequencyCollate = FALSE AND globals::__FirstPass THEN 
                IF __FrequencyCollate = FALSE AND __Part1DestFileValue <> "" THEN 
                    ALTER CHANNEL __Part1Dest FILE __Part1DestFileValue
                END IF 
            END IF 
            IF __FrequencyCollate = FALSE OR globals::__FirstPass THEN 
                SET OUTPUT __Part1Dest
            END IF 
        END IF 
        IGNORE WORKSHEET "Part1L2WS"
    END IF 
    IF __Part1L3_Break THEN 
        CLEAN WORKSHEET "Part1L3WS"
        LET Part1L3WS::__RegionCount = 0
        LET Part1L3WS::__InstanceCount = 0
    END IF 
    IF NOT globals::__LastPass THEN 
        SEARCH WORKSHEET "Part1L3WS"
        SET WORKSHEET "Part1L3WS"
        CALL "__AppendInputDataToPart1L3WS"
        IGNORE WORKSHEET "Part1L3WS"
    END IF 
    IF __CurrentWorksheet = "Part1L3WS" THEN 
        SEARCH WORKSHEET "Part1L3WS"
        IF __Part1Dest <> "" THEN 
            IF __Part1DestFile <> "" THEN 
                LET __Part1DestFileValue = VALUE(__Part1DestFile)
            ELSE 
                LET __Part1DestFileValue = ""
            END IF 
            IF __FrequencyCollate = FALSE AND globals::__FirstPass THEN 
                IF __FrequencyCollate = FALSE AND __Part1DestFileValue <> "" THEN 
                    ALTER CHANNEL __Part1Dest FILE __Part1DestFileValue
                END IF 
            END IF 
            IF __FrequencyCollate = FALSE OR globals::__FirstPass THEN 
                SET OUTPUT __Part1Dest
            END IF 
        END IF 
        IGNORE WORKSHEET "Part1L3WS"
    END IF 
    IF __Part1L4_Break THEN 
        CLEAN WORKSHEET "Part1L4WS"
        LET Part1L4WS::__RegionCount = 0
        LET Part1L4WS::__InstanceCount = 0
    END IF 
    IF NOT globals::__LastPass THEN 
        SEARCH WORKSHEET "Part1L4WS"
        SET WORKSHEET "Part1L4WS"
        CALL "__AppendInputDataToPart1L4WS"
        IGNORE WORKSHEET "Part1L4WS"
    END IF 
    IF __CurrentWorksheet = "Part1L4WS" THEN 
        SEARCH WORKSHEET "Part1L4WS"
        IF __Part1Dest <> "" THEN 
            IF __Part1DestFile <> "" THEN 
                LET __Part1DestFileValue = VALUE(__Part1DestFile)
            ELSE 
                LET __Part1DestFileValue = ""
            END IF 
            IF __FrequencyCollate = FALSE AND globals::__FirstPass THEN 
                IF __FrequencyCollate = FALSE AND __Part1DestFileValue <> "" THEN 
                    ALTER CHANNEL __Part1Dest FILE __Part1DestFileValue
                END IF 
            END IF 
            IF __FrequencyCollate = FALSE OR globals::__FirstPass THEN 
                SET OUTPUT __Part1Dest
            END IF 
        END IF 
        IGNORE WORKSHEET "Part1L4WS"
    END IF 
    IF __Part1L5_Break THEN 
        CLEAN WORKSHEET "Part1L5WS"
        LET Part1L5WS::__RegionCount = 0
        LET Part1L5WS::__InstanceCount = 0
    END IF 
    IF NOT globals::__LastPass THEN 
        SEARCH WORKSHEET "Part1L5WS"
        SET WORKSHEET "Part1L5WS"
        CALL "__AppendInputDataToPart1L5WS"
        IGNORE WORKSHEET "Part1L5WS"
    END IF 
    IF __CurrentWorksheet = "Part1L5WS" THEN 
        SEARCH WORKSHEET "Part1L5WS"
        IF __Part1Dest <> "" THEN 
            IF __Part1DestFile <> "" THEN 
                LET __Part1DestFileValue = VALUE(__Part1DestFile)
            ELSE 
                LET __Part1DestFileValue = ""
            END IF 
            IF __FrequencyCollate = FALSE AND globals::__FirstPass THEN 
                IF __FrequencyCollate = FALSE AND __Part1DestFileValue <> "" THEN 
                    ALTER CHANNEL __Part1Dest FILE __Part1DestFileValue
                END IF 
            END IF 
            IF __FrequencyCollate = FALSE OR globals::__FirstPass THEN 
                SET OUTPUT __Part1Dest
            END IF 
        END IF 
        IGNORE WORKSHEET "Part1L5WS"
    END IF 
    IF __Part1L6_Break THEN 
        CLEAN WORKSHEET "Part1L6WS"
        LET Part1L6WS::__RegionCount = 0
        LET Part1L6WS::__InstanceCount = 0
    END IF 
    IF NOT globals::__LastPass THEN 
        SEARCH WORKSHEET "Part1L6WS"
        SET WORKSHEET "Part1L6WS"
        CALL "__AppendInputDataToPart1L6WS"
        IGNORE WORKSHEET "Part1L6WS"
    END IF 
    IF __CurrentWorksheet = "Part1L6WS" THEN 
        SEARCH WORKSHEET "Part1L6WS"
        IF __Part1Dest <> "" THEN 
            IF __Part1DestFile <> "" THEN 
                LET __Part1DestFileValue = VALUE(__Part1DestFile)
            ELSE 
                LET __Part1DestFileValue = ""
            END IF 
            IF __FrequencyCollate = FALSE AND globals::__FirstPass THEN 
                IF __FrequencyCollate = FALSE AND __Part1DestFileValue <> "" THEN 
                    ALTER CHANNEL __Part1Dest FILE __Part1DestFileValue
                END IF 
            END IF 
            IF __FrequencyCollate = FALSE OR globals::__FirstPass THEN 
                SET OUTPUT __Part1Dest
            END IF 
        END IF 
        IGNORE WORKSHEET "Part1L6WS"
    END IF 
    IF Part1L1WS::__CleanConditionNextPage AND Part1L2WS::__CleanConditionNextPage THEN 
        LET Part1L1WS::__CleanConditionNextPage = FALSE
        LET Part1L2WS::__CleanConditionNextPage = FALSE
        LET globals::__CleanConditionNextPagePart1 = TRUE
    END IF 
    IF Part1L3WS::__CleanConditionNextPage THEN 
        LET Part1L3WS::__CleanConditionNextPage = FALSE
        LET globals::__CleanConditionNextPagePart1 = TRUE
    END IF 
    IF Part1L4WS::__CleanConditionNextPage THEN 
        LET Part1L4WS::__CleanConditionNextPage = FALSE
        LET globals::__CleanConditionNextPagePart1 = TRUE
    END IF 
    IF Part1L5WS::__CleanConditionNextPage THEN 
        LET Part1L5WS::__CleanConditionNextPage = FALSE
        LET globals::__CleanConditionNextPagePart1 = TRUE
    END IF 
    IF Part1L6WS::__CleanConditionNextPage THEN 
        LET Part1L6WS::__CleanConditionNextPage = FALSE
        LET globals::__CleanConditionNextPagePart1 = TRUE
    END IF 
    IGNORE WORKSHEET "Part1ConditionWS"
END PART 

FUNCTION "__InitWorksheets"
    CREATE WORKSHEET "PrimaryInputWS"
    LET PrimaryInputWS::__SectionStartLine[1] = 1
    LET PrimaryInputWS::__SectionLevel[1] = 1
    LET PrimaryInputWS::__SectionRepeating[1] = FALSE
    LET PrimaryInputWS::__SectionName[1] = "Header"
    LET PrimaryInputWS::__SectionOffset[1] = 0
    LET PrimaryInputWS::__SectionParent[1] = 0
    LET PrimaryInputWS::__SectionWatchPatternType[1] = 0
    LET PrimaryInputWS::__SectionBufferAccess[1] = ""
    LET PrimaryInputWS::__SectionType[1] = "TEXT"
    LET PrimaryInputWS::__SectionCount = 1
    LET PrimaryInputWS::__SectionLevelCount = 1
    LET PrimaryInputWS::__MaxRows = 66
    LET PrimaryInputWS::__InputType = "TEXT"
    PROTECT PrimaryInputWS::__SectionStartLine
    PROTECT PrimaryInputWS::__SectionLevel
    PROTECT PrimaryInputWS::__SectionRepeating
    PROTECT PrimaryInputWS::__SectionName
    PROTECT PrimaryInputWS::__SectionOffset
    PROTECT PrimaryInputWS::__SectionParent
    PROTECT PrimaryInputWS::__SectionWatchPatternType
    PROTECT PrimaryInputWS::__SectionBufferAccess
    PROTECT PrimaryInputWS::__SectionType
    PROTECT PrimaryInputWS::__SectionCount
    PROTECT PrimaryInputWS::__SectionLevelCount
    PROTECT PrimaryInputWS::__MaxRows
    PROTECT PrimaryInputWS::__InputType
    CREATE WORKSHEET "Part1L1WS"
    LET Part1L1WS::__RegionCount = 0
    CREATE WORKSHEET "Part1L2WS"
    LET Part1L2WS::__RegionCount = 0
    CREATE WORKSHEET "Part1L3WS"
    LET Part1L3WS::__RegionCount = 0
    CREATE WORKSHEET "Part1L4WS"
    LET Part1L4WS::__RegionCount = 0
    CREATE WORKSHEET "Part1L5WS"
    LET Part1L5WS::__RegionCount = 0
    CREATE WORKSHEET "Part1L6WS"
    LET Part1L6WS::__RegionCount = 0
    CREATE WORKSHEET "Part1ConditionWS"
    LET Part1ConditionWS::__PageCount = 0
    PROTECT Part1ConditionWS::__PageCount
    LET Part1L1WS::__SinglePageOnly = FALSE
    LET Part1L1WS::__LayoutUpperBoundarySingle = 2090
    LET Part1L1WS::__LayoutLowerBoundarySingle = 3184
    LET Part1L1WS::__LayoutUpperBoundaryLast = 300
    LET Part1L1WS::__LayoutLowerBoundaryLast = 3000
    LET Part1L1WS::__OutSectionCount = 0
    LET Part1L1WS::__CleanConditionNextPage = FALSE
    PROTECT Part1L1WS::__CleanConditionNextPage
    PROTECT Part1L1WS::__SinglePageOnly
    PROTECT Part1L1WS::__LayoutUpperBoundarySingle
    PROTECT Part1L1WS::__LayoutLowerBoundarySingle
    PROTECT Part1L1WS::__LayoutUpperBoundaryLast
    PROTECT Part1L1WS::__LayoutLowerBoundaryLast
    PROTECT Part1L1WS::__OutSectionCount
    LET Part1L2WS::__SinglePageOnly = FALSE
    LET Part1L2WS::__LayoutUpperBoundarySingle = 2090
    LET Part1L2WS::__LayoutLowerBoundarySingle = 3184
    LET Part1L2WS::__LayoutUpperBoundaryLast = 300
    LET Part1L2WS::__LayoutLowerBoundaryLast = 3000
    LET Part1L2WS::__OutSectionCount = 0
    LET Part1L2WS::__CleanConditionNextPage = FALSE
    PROTECT Part1L2WS::__CleanConditionNextPage
    PROTECT Part1L2WS::__SinglePageOnly
    PROTECT Part1L2WS::__LayoutUpperBoundarySingle
    PROTECT Part1L2WS::__LayoutLowerBoundarySingle
    PROTECT Part1L2WS::__LayoutUpperBoundaryLast
    PROTECT Part1L2WS::__LayoutLowerBoundaryLast
    PROTECT Part1L2WS::__OutSectionCount
    LET Part1L3WS::__SinglePageOnly = FALSE
    LET Part1L3WS::__LayoutUpperBoundarySingle = 1931
    LET Part1L3WS::__LayoutLowerBoundarySingle = 3000
    LET Part1L3WS::__LayoutUpperBoundaryLast = 300
    LET Part1L3WS::__LayoutLowerBoundaryLast = 3000
    LET Part1L3WS::__OutSectionCount = 0
    LET Part1L3WS::__CleanConditionNextPage = FALSE
    PROTECT Part1L3WS::__CleanConditionNextPage
    PROTECT Part1L3WS::__SinglePageOnly
    PROTECT Part1L3WS::__LayoutUpperBoundarySingle
    PROTECT Part1L3WS::__LayoutLowerBoundarySingle
    PROTECT Part1L3WS::__LayoutUpperBoundaryLast
    PROTECT Part1L3WS::__LayoutLowerBoundaryLast
    PROTECT Part1L3WS::__OutSectionCount
    LET Part1L4WS::__SinglePageOnly = FALSE
    LET Part1L4WS::__LayoutUpperBoundarySingle = 2090
    LET Part1L4WS::__LayoutLowerBoundarySingle = 3184
    LET Part1L4WS::__LayoutUpperBoundaryLast = 300
    LET Part1L4WS::__LayoutLowerBoundaryLast = 3000
    LET Part1L4WS::__OutSectionCount = 0
    LET Part1L4WS::__CleanConditionNextPage = FALSE
    PROTECT Part1L4WS::__CleanConditionNextPage
    PROTECT Part1L4WS::__SinglePageOnly
    PROTECT Part1L4WS::__LayoutUpperBoundarySingle
    PROTECT Part1L4WS::__LayoutLowerBoundarySingle
    PROTECT Part1L4WS::__LayoutUpperBoundaryLast
    PROTECT Part1L4WS::__LayoutLowerBoundaryLast
    PROTECT Part1L4WS::__OutSectionCount
    LET Part1L5WS::__SinglePageOnly = FALSE
    LET Part1L5WS::__LayoutUpperBoundarySingle = 2090
    LET Part1L5WS::__LayoutLowerBoundarySingle = 3184
    LET Part1L5WS::__LayoutUpperBoundaryLast = 300
    LET Part1L5WS::__LayoutLowerBoundaryLast = 3000
    LET Part1L5WS::__OutSectionCount = 0
    LET Part1L5WS::__CleanConditionNextPage = FALSE
    PROTECT Part1L5WS::__CleanConditionNextPage
    PROTECT Part1L5WS::__SinglePageOnly
    PROTECT Part1L5WS::__LayoutUpperBoundarySingle
    PROTECT Part1L5WS::__LayoutLowerBoundarySingle
    PROTECT Part1L5WS::__LayoutUpperBoundaryLast
    PROTECT Part1L5WS::__LayoutLowerBoundaryLast
    PROTECT Part1L5WS::__OutSectionCount
    LET Part1L6WS::__SinglePageOnly = FALSE
    LET Part1L6WS::__LayoutUpperBoundarySingle = 315
    LET Part1L6WS::__LayoutLowerBoundarySingle = 3000
    LET Part1L6WS::__LayoutUpperBoundaryLast = 300
    LET Part1L6WS::__LayoutLowerBoundaryLast = 3000
    LET Part1L6WS::__OutSectionCount = 0
    LET Part1L6WS::__CleanConditionNextPage = FALSE
    PROTECT Part1L6WS::__CleanConditionNextPage
    PROTECT Part1L6WS::__SinglePageOnly
    PROTECT Part1L6WS::__LayoutUpperBoundarySingle
    PROTECT Part1L6WS::__LayoutLowerBoundarySingle
    PROTECT Part1L6WS::__LayoutUpperBoundaryLast
    PROTECT Part1L6WS::__LayoutLowerBoundaryLast
    PROTECT Part1L6WS::__OutSectionCount
END FUNCTION 

FUNCTION "__AppendInputDataToPart1L1WS"
    IF __Sections.Count > 0 THEN 
        LET __CurrentSectionCount = __Sections.Count
    ELSE 
        LET __CurrentSectionCount = 0
    END IF 
    USE Layout.Background
    LET .__SectionInstance = TRUE
    FOR __Counter = 1 TO globals::__InputIndex
        FOR __Counter0 = __CurrentSectionCount + 1 TO __Sections.Count
            IF __Sections.Instances{__Counter0}.__InputIndex = __Counter THEN 
                LET Part1L1WS::__RegionName[0] = __Sections.Instances{__Counter0}.Name
                LET Part1L1WS::__RegionRepeating[0] = __Sections.Instances{__Counter0}.__SectionRepeating
                LET Part1L1WS::__RegionLevel[0] = __Sections.Instances{__Counter0}.__RegionLevel
                LET Part1L1WS::__RegionNum[0] = __Counter0
                LET Part1L1WS::__RegionCount = Part1L1WS::__RegionCount + 1
                EXIT FOR 
            END IF 
        END FOR 
    END FOR 
    IF globals::__InputIndex > 0 THEN 
        LET __RegionMapped = TRUE
    ELSE 
        LET __RegionMapped = FALSE
    END IF 
END FUNCTION 

FUNCTION "__AppendInputDataToPart1L2WS"
    IF __Sections.Count > 0 THEN 
        LET __CurrentSectionCount = __Sections.Count
    ELSE 
        LET __CurrentSectionCount = 0
    END IF 
    USE Layout.Background3
    LET .__SectionInstance = TRUE
    FOR __Counter = 1 TO globals::__InputIndex
        FOR __Counter0 = __CurrentSectionCount + 1 TO __Sections.Count
            IF __Sections.Instances{__Counter0}.__InputIndex = __Counter THEN 
                LET Part1L2WS::__RegionName[0] = __Sections.Instances{__Counter0}.Name
                LET Part1L2WS::__RegionRepeating[0] = __Sections.Instances{__Counter0}.__SectionRepeating
                LET Part1L2WS::__RegionLevel[0] = __Sections.Instances{__Counter0}.__RegionLevel
                LET Part1L2WS::__RegionNum[0] = __Counter0
                LET Part1L2WS::__RegionCount = Part1L2WS::__RegionCount + 1
                EXIT FOR 
            END IF 
        END FOR 
    END FOR 
    IF globals::__InputIndex > 0 THEN 
        LET __RegionMapped = TRUE
    ELSE 
        LET __RegionMapped = FALSE
    END IF 
END FUNCTION 

FUNCTION "__AppendInputDataToPart1L3WS"
    IF __Sections.Count > 0 THEN 
        LET __CurrentSectionCount = __Sections.Count
    ELSE 
        LET __CurrentSectionCount = 0
    END IF 
    USE Layout.Background2
    LET .__SectionInstance = TRUE
    FOR __Counter = 1 TO globals::__InputIndex
        FOR __Counter0 = __CurrentSectionCount + 1 TO __Sections.Count
            IF __Sections.Instances{__Counter0}.__InputIndex = __Counter THEN 
                LET Part1L3WS::__RegionName[0] = __Sections.Instances{__Counter0}.Name
                LET Part1L3WS::__RegionRepeating[0] = __Sections.Instances{__Counter0}.__SectionRepeating
                LET Part1L3WS::__RegionLevel[0] = __Sections.Instances{__Counter0}.__RegionLevel
                LET Part1L3WS::__RegionNum[0] = __Counter0
                LET Part1L3WS::__RegionCount = Part1L3WS::__RegionCount + 1
                EXIT FOR 
            END IF 
        END FOR 
    END FOR 
    IF globals::__InputIndex > 0 THEN 
        LET __RegionMapped = TRUE
    ELSE 
        LET __RegionMapped = FALSE
    END IF 
END FUNCTION 

FUNCTION "__AppendInputDataToPart1L4WS"
    IF __Sections.Count > 0 THEN 
        LET __CurrentSectionCount = __Sections.Count
    ELSE 
        LET __CurrentSectionCount = 0
    END IF 
    USE Layout.Background
    LET .__SectionInstance = TRUE
    FOR __Counter = 1 TO globals::__InputIndex
        FOR __Counter0 = __CurrentSectionCount + 1 TO __Sections.Count
            IF __Sections.Instances{__Counter0}.__InputIndex = __Counter THEN 
                LET Part1L4WS::__RegionName[0] = __Sections.Instances{__Counter0}.Name
                LET Part1L4WS::__RegionRepeating[0] = __Sections.Instances{__Counter0}.__SectionRepeating
                LET Part1L4WS::__RegionLevel[0] = __Sections.Instances{__Counter0}.__RegionLevel
                LET Part1L4WS::__RegionNum[0] = __Counter0
                LET Part1L4WS::__RegionCount = Part1L4WS::__RegionCount + 1
                EXIT FOR 
            END IF 
        END FOR 
    END FOR 
    IF globals::__InputIndex > 0 THEN 
        LET __RegionMapped = TRUE
    ELSE 
        LET __RegionMapped = FALSE
    END IF 
END FUNCTION 

FUNCTION "__AppendInputDataToPart1L5WS"
    IF __Sections.Count > 0 THEN 
        LET __CurrentSectionCount = __Sections.Count
    ELSE 
        LET __CurrentSectionCount = 0
    END IF 
    USE Layout.Background
    LET .__SectionInstance = TRUE
    FOR __Counter = 1 TO globals::__InputIndex
        FOR __Counter0 = __CurrentSectionCount + 1 TO __Sections.Count
            IF __Sections.Instances{__Counter0}.__InputIndex = __Counter THEN 
                LET Part1L5WS::__RegionName[0] = __Sections.Instances{__Counter0}.Name
                LET Part1L5WS::__RegionRepeating[0] = __Sections.Instances{__Counter0}.__SectionRepeating
                LET Part1L5WS::__RegionLevel[0] = __Sections.Instances{__Counter0}.__RegionLevel
                LET Part1L5WS::__RegionNum[0] = __Counter0
                LET Part1L5WS::__RegionCount = Part1L5WS::__RegionCount + 1
                EXIT FOR 
            END IF 
        END FOR 
    END FOR 
    IF globals::__InputIndex > 0 THEN 
        LET __RegionMapped = TRUE
    ELSE 
        LET __RegionMapped = FALSE
    END IF 
END FUNCTION 

FUNCTION "__AppendInputDataToPart1L6WS"
    IF __Sections.Count > 0 THEN 
        LET __CurrentSectionCount = __Sections.Count
    ELSE 
        LET __CurrentSectionCount = 0
    END IF 
    USE Layout.Background1
    LET .__SectionInstance = TRUE
    FOR __Counter = 1 TO globals::__InputIndex
        FOR __Counter0 = __CurrentSectionCount + 1 TO __Sections.Count
            IF __Sections.Instances{__Counter0}.__InputIndex = __Counter THEN 
                LET Part1L6WS::__RegionName[0] = __Sections.Instances{__Counter0}.Name
                LET Part1L6WS::__RegionRepeating[0] = __Sections.Instances{__Counter0}.__SectionRepeating
                LET Part1L6WS::__RegionLevel[0] = __Sections.Instances{__Counter0}.__RegionLevel
                LET Part1L6WS::__RegionNum[0] = __Counter0
                LET Part1L6WS::__RegionCount = Part1L6WS::__RegionCount + 1
                EXIT FOR 
            END IF 
        END FOR 
    END FOR 
    IF globals::__InputIndex > 0 THEN 
        LET __RegionMapped = TRUE
    ELSE 
        LET __RegionMapped = FALSE
    END IF 
END FUNCTION 

CHANNEL "cu4504"
    LIKE "stdin" 
    ROWS 66
    COLUMNS 132
    BUFFER @
    FORMFEEDS "YES"
    RETURNS "YES"
    LINEFEEDS "YES"
    CONTROLS "NO"
    TABS "YES"
END CHANNEL 

CHANNEL "Laser Printer"
    PRINTER print_dest
    DEVICE "pcl5gl2Lt.dev"
END CHANNEL 

CHANNEL "Laser Printer2"
    PRINTER print_dest
    DEVICE "pcl5gl2Lt.dev"
END CHANNEL 

CHANNEL "Email" LIKE "smtp"
    DEVICE "MyDeviceLt.dev"
    PORT 25
    SERVER "server"
END CHANNEL 

CHANNEL "Pcl"
    FILE "optio.out"
    DEVICE "MyDeviceLt.dev"
    MODE "WRITE"
END CHANNEL 

CHANNEL "Pdf"
    FILE print_dest
    DEVICE "pdf.dev"
    MODE "WRITE"
END CHANNEL 

FORMAT "cu3404_p1"
    UNITS "DPI300"
    FEEDER __LayoutFeeder
    PAPER __LayoutPaper
    DUPLEX __LayoutDuplex
    SURFACE __LayoutSurface
    LAYOUT __LayoutLayout
    STACKER __LayoutStacker
    MACRO __LayoutMacro
    MACROS __LayoutMacrosMin:__LayoutMacrosMax
    ALIGN "TOPLEFT"
    LINESTYLE "SOLID"
    LET __InputInstance = 1
    LET __CurrentPagePosition = 1
    IF __PageType = "SINGLE" OR __PageType = "FIRST" OR __PageType = "MIDDLE" OR __PageType = "LAST" THEN 
        DRAW "Background"
    END IF 
END FORMAT 

FORMAT "no print"
    UNITS "DPI300"
    FEEDER __LayoutFeeder
    PAPER __LayoutPaper
    DUPLEX __LayoutDuplex
    SURFACE __LayoutSurface
    LAYOUT __LayoutLayout
    STACKER __LayoutStacker
    MACRO __LayoutMacro
    MACROS __LayoutMacrosMin:__LayoutMacrosMax
    ALIGN "TOPLEFT"
    LINESTYLE "SOLID"
    LET __InputInstance = 1
    LET __CurrentPagePosition = 0
    IF __PageType = "SINGLE" OR __PageType = "FIRST" OR __PageType = "MIDDLE" OR __PageType = "LAST" THEN 
        DRAW "Background1"
    END IF 
END FORMAT 

FORMAT "shell2"
    UNITS "DPI300"
    FEEDER __LayoutFeeder
    PAPER __LayoutPaper
    DUPLEX __LayoutDuplex
    SURFACE __LayoutSurface
    LAYOUT __LayoutLayout
    STACKER __LayoutStacker
    MACRO __LayoutMacro
    MACROS __LayoutMacrosMin:__LayoutMacrosMax
    ALIGN "TOPLEFT"
    LINESTYLE "SOLID"
    LET __InputInstance = 1
    LET __CurrentPagePosition = 0
    IF __PageType = "SINGLE" OR __PageType = "FIRST" OR __PageType = "MIDDLE" OR __PageType = "LAST" THEN 
        DRAW "Background2"
    END IF 
END FORMAT 

FORMAT "cu3404_p2"
    UNITS "DPI300"
    FEEDER __LayoutFeeder
    PAPER __LayoutPaper
    DUPLEX __LayoutDuplex
    SURFACE __LayoutSurface
    LAYOUT __LayoutLayout
    STACKER __LayoutStacker
    MACRO __LayoutMacro
    MACROS __LayoutMacrosMin:__LayoutMacrosMax
    ALIGN "TOPLEFT"
    LINESTYLE "SOLID"
    LET __InputInstance = 1
    LET __CurrentPagePosition = 1
    IF __PageType = "SINGLE" OR __PageType = "FIRST" OR __PageType = "MIDDLE" OR __PageType = "LAST" THEN 
        DRAW "Background3"
    END IF 
END FORMAT 

DATAMAP "Text Data Datamap"
    LINES 66
    LET __InputSize = ROWS(@)

    CALL "__CreateRegionMapping"

    LET __FirstRepeatingSection = TRUE

    FOR __Counter = 1 TO __RegionCount
        LET __CurrentRegionNum = __RegionNum[__Counter]
        LET __CurrentRegionStart = __RegionStart[__Counter]
        LET __CurrentRegionLength = __RegionLength[__Counter]
        LET __CurrentRegionContinuation = __RegionContinue[__Counter]
        SWITCH __CurrentRegionNum
            CASE 1
                MAP "Header"
                // Beginning of Code After
                //LET syscommand = SYSTEM("D:\Program Files\Traction Software\Batch & Print Pro\Batch And Print.exe D:\Documents and Settings\All Users\Application Data\Optio\OECI\7.7\images\DOC\HODEC199.doc")
                // End of Code After
                EXIT SWITCH 
        END SWITCH 
    END FOR 
END DATAMAP 

REGION "Header"
    LINE __CurrentRegionStart
    LENGTH __CurrentRegionLength
    LET __NumInstances1 = NODECOUNT(PrimaryInputWS::PrimaryInput, "Header") + 1
    LET globals::__InputIndex = __InputIndex + 1
    LET PrimaryInputWS::PrimaryInput.Header{__NumInstances1}.__InputIndex = __InputIndex
    LET PrimaryInputWS::PrimaryInput.Header{__NumInstances1}.__ContinuationRegion = __CurrentRegionContinuation
    LET PrimaryInputWS::PrimaryInput.Header{__NumInstances1}.__RegionLevel = __SectionLevel[__CurrentRegionNum]
    LET __StartLine = !+1
    LET __EndLine = !+1
    LET PrimaryInputWS::PrimaryInput.Header{__NumInstances1}.form_type{1} = PRUNE(@[__StartLine -> __EndLine, 4 -> 13])
    LET __StartLine = !+1
    LET __EndLine = !+1
    LET PrimaryInputWS::PrimaryInput.Header{__NumInstances1}.dec_page_num{1} = PRUNE(@[__StartLine -> __EndLine, 27 -> 32])
    LET __StartLine = !+1
    LET __EndLine = !+1
    LET PrimaryInputWS::PrimaryInput.Header{__NumInstances1}.print_dest1{1} = PRUNE(@[__StartLine -> __EndLine, 33 -> 82])
END REGION 

SEGMENT "Background"
    UNITS "DPI300"
    DESTROY __OutputField
    LET __OutputField = <<"CU3404-1.tif">>
    DRAW IMAGE AT __CurrentPagePosition + 0, 0
        USING __OutputField
        SCALE 100, 100
END SEGMENT 

SEGMENT "Background1"
    UNITS "DPI300"
END SEGMENT 

SEGMENT "Background2"
    UNITS "DPI300"
END SEGMENT 

SEGMENT "Background3"
    UNITS "DPI300"
    DESTROY __OutputField
    LET __OutputField = <<"CU3404-2.tif">>
    DRAW IMAGE AT __CurrentPagePosition + -1, 0
        USING __OutputField
        SCALE 100, 100
END SEGMENT 

!!EOF

OBJECT ( TYPE="Control" , NAME="" , DELIM=0 )
{
  763 3607035065 2801624335 1033 
}

!!EndOfControl

OBJECT ( TYPE="INPUT_TEXT" , NAME="cu4504" , DELIM=$ )
{
  $  3 
    1 
    #OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
    {
      8 26 
      1 '0 1 0 0 0 "cu4504" ' 
      2 "0 1 1 0 0 " 
      3 !0 1 0 0 0 '//SET TRACE FILE "~errors\error.log"//SET TRACE MASK TRACEMASK("ALL")' ! 
      4 '0 1 0 0 0 "" ' 
      5 "0 0 0 0 0 0 " 
      6 "0 0 0 0 0 0 " 
      9 "0 0 0 0 0 1 " 
      10 '1 0 0 0 0 "1:27296554BAAE4C8CAA13A83905F68401" ' 
      101 "0 0 0 0 0 268 " 
      102 "0 0 0 0 0 22 " 
      103 '0 0 0 0 0 "input.ico" ' 
      110 '0 1 0 0 0 "YES" ' 
      111 '0 1 0 0 0 "YES" ' 
      112 '0 1 0 0 0 "YES" ' 
      113 "0 1 0 0 0 66 " 
      122 "0 1 0 0 0 1 " 
      131 '0 1 0 0 0 "YES" ' 
      132 '0 1 0 0 0 "NO" ' 
      134 '0 1 0 0 0 "@" ' 
      135 "0 1 0 0 0 132 " 
      136 "1 1 0 0 0 1 " 
      138 '0 1 0 0 0 "C:\Users\lcruz\Documents\Optio\DesignStudio\7.8\samples\p7cudecins.txt" ' 
      200 "0 0 0 0 0 1 " 
      331 "0 1 0 0 0 0 " 
      389 "0 0 1 0 0 " 
      390 "0 1 1 0 0 " 
    }
    #

    1 "21:157ED034F5994892A5E494F128FF65B3" 0 $ 
}
OBJECT ( TYPE="DESTINATION_LASER_PRINTER" , NAME="Laser Printer" , DELIM=@ )
{
  @  1 
    1 
    !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
    {
      8 14 
      1 '0 1 0 0 0 "Laser Printer" ' 
      2 "0 1 1 0 0 " 
      3 '0 1 0 0 0 "" ' 
      4 "0 1 1 0 0 " 
      5 "0 0 0 0 0 0 " 
      6 "0 0 0 0 0 0 " 
      9 "0 0 0 0 0 1 " 
      10 '1 0 0 0 0 "7:F0014345DD2B4BE59E15D46AD152682F" ' 
      104 '0 1 0 0 0 "" ' 
      105 '0 1 0 1 0 "pcl5gl2Lt.dev" "" ' 
      109 "1 1 1 0 0 " 
      277 '0 1 0 0 0 "=print_dest" ' 
      458 "0 1 0 0 0 1 " 
      473 "0 1 0 0 0 0 " 
    }
    !

  @ 
}
OBJECT ( TYPE="DESTINATION_LASER_PRINTER" , NAME="Laser Printer2" , DELIM=@ )
{
  @  1 
    1 
    !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
    {
      8 14 
      1 '0 1 0 0 0 "Laser Printer2" ' 
      2 "0 1 1 0 0 " 
      3 '0 1 0 0 0 "" ' 
      4 "0 1 1 0 0 " 
      5 "0 0 0 0 0 0 " 
      6 "0 0 0 0 0 0 " 
      9 "0 0 0 0 0 1 " 
      10 '1 0 0 0 0 "7:C4296FD975E344BDA28990356B37DAFD" ' 
      104 '0 1 0 0 0 "" ' 
      105 '0 1 0 1 0 "pcl5gl2Lt.dev" "" ' 
      109 "1 1 1 0 0 " 
      277 '0 1 0 0 0 "=print_dest" ' 
      458 "0 1 0 0 0 1 " 
      473 "0 1 0 0 0 0 " 
    }
    !

  @ 
}
OBJECT ( TYPE="DESTINATION_EMAIL" , NAME="Email" , DELIM=@ )
{
  @  1 
    1 
    !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
    {
      8 29 
      1 '0 1 0 0 0 "Email" ' 
      2 "0 1 1 0 0 " 
      3 "0 1 1 0 0 " 
      4 "0 1 1 0 0 " 
      5 "0 0 0 0 0 0 " 
      6 "0 0 0 0 0 0 " 
      9 "0 0 0 0 0 1 " 
      10 '1 0 0 0 0 "9:4E1DA4C1A9EB4258BDEF63AFEB0779F1" ' 
      104 "0 1 1 0 0 " 
      105 '0 1 0 1 0 "MyDeviceLt.dev" "" ' 
      109 "1 1 1 0 0 " 
      117 '0 1 0 0 0 "25" ' 
      118 '0 1 0 0 0 "server" ' 
      144 "0 1 0 0 0 1 " 
      182 '0 1 0 0 0 "smtp" ' 
      229 "0 1 1 0 0 " 
      230 "0 1 1 0 0 " 
      231 "0 1 1 0 0 " 
      232 "0 1 1 0 0 " 
      233 "0 1 1 0 0 " 
      234 "0 1 1 0 0 " 
      235 "0 1 1 0 0 " 
      236 "0 1 1 0 0 " 
      237 "0 1 1 0 0 " 
      238 "0 1 1 0 0 " 
      283 "0 1 0 0 0 0 " 
      400 "0 1 0 0 0 0 " 
      441 "0 1 0 0 0 0 " 
      442 "0 1 1 0 0 " 
    }
    !

  @ 
}
OBJECT ( TYPE="DESTINATION_FILE" , NAME="Pcl" , DELIM=@ )
{
  @  1 
    1 
    !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
    {
      8 18 
      1 '0 1 0 0 0 "Pcl" ' 
      2 "0 1 1 0 0 " 
      3 "0 1 1 0 0 " 
      4 "0 1 1 0 0 " 
      5 "0 0 0 0 0 0 " 
      6 "0 0 0 0 0 0 " 
      9 "0 0 0 0 0 1 " 
      10 '1 0 0 0 0 "5:E4D03F72AFE54C5CBCEF92524E449F5B" ' 
      104 "0 1 1 0 0 " 
      105 '0 1 0 1 0 "MyDeviceLt.dev" "" ' 
      109 "1 1 1 0 0 " 
      112 '0 1 0 0 0 "YES" ' 
      130 '0 1 0 0 0 "optio.out" ' 
      283 "0 1 0 0 0 0 " 
      400 "0 1 0 0 0 0 " 
      449 '0 1 0 0 0 "WRITE" ' 
      453 "0 1 0 0 0 0 " 
      458 "0 1 0 0 0 1 " 
    }
    !

  @ 
}
OBJECT ( TYPE="DESTINATION_FILE" , NAME="Pdf" , DELIM=@ )
{
  @  1 
    1 
    !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
    {
      8 17 
      1 '0 1 0 0 0 "Pdf" ' 
      2 "0 1 1 0 0 " 
      3 '0 1 0 0 0 "" ' 
      4 '0 1 0 0 0 "" ' 
      5 "0 0 0 0 0 0 " 
      6 "0 0 0 0 0 0 " 
      9 "0 0 0 0 0 1 " 
      10 '1 0 0 0 0 "5:F6173733D467442D81D450B05513E316" ' 
      104 "0 1 1 0 0 " 
      105 '0 1 0 1 0 "pdf.dev" "" ' 
      109 "1 1 1 0 0 " 
      130 '0 1 0 0 0 "=print_dest" ' 
      283 "0 1 0 0 0 0 " 
      400 "0 1 0 0 0 0 " 
      449 '0 1 0 0 0 "WRITE" ' 
      453 "0 1 0 0 0 0 " 
      458 "0 1 0 0 0 1 " 
    }
    !

  @ 
}
OBJECT ( TYPE="LAYOUT_FORMAT" , NAME="cu3404_p1" , DELIM=@ )
{
  @  6 
    1 
    !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
    {
      8 56 
      1 '0 1 0 0 0 "cu3404_p1" ' 
      2 "0 1 1 0 0 " 
      3 '0 1 0 0 0 "" ' 
      4 '0 1 0 0 0 "" ' 
      5 "0 0 0 0 0 0 " 
      6 "0 0 0 0 0 0 " 
      9 "0 0 1 0 0 " 
      10 '1 0 0 0 0 "13:F1772AAB3E02421AAC10CDBE39E7BB4E" ' 
      104 '0 1 0 0 0 "" ' 
      109 "1 1 1 0 0 " 
      156 '0 1 0 0 0 "DPI300" ' 
      157 "0 1 1 1 0 " 
      158 '0 1 0 1 1 "SOLID" "" 5 3 2039 "SOLID" 2040 "DASH" 2041 "DOT" 2042 "DASHDOT" 2043 "DASHDOTDOT" ' 
      159 '0 1 1 1 1 1 3 2058 "SQUARED" ' 
      160 "0 1 1 1 0 " 
      161 "0 1 1 1 0 " 
      162 '0 1 0 1 1 "NONE" "" 17 3 2062 "NONE" 2063 "USER" 2064 "HC" 2078 "DC" 2065 "HS" 2066 "VS" 2067 "TS" 2068 "BS" 2069 "WHITE" 2070 "GREY1" 2071 "GREY2" 2072 "GREY3" 2073 "GREY4" 2074 "GREY5" 2075 "GREY6" 2076 "GREY7" 2077 "BLACK" ' 
      163 "0 1 1 1 0 " 
      164 "0 1 1 1 0 " 
      165 "0 1 1 1 0 " 
      166 "0 1 1 1 0 " 
      167 "1 0 1 1 0 " 
      168 "0 1 1 1 0 " 
      169 "0 1 1 1 0 " 
      170 "0 1 1 1 0 " 
      171 '0 1 0 1 1 "Helvetica" "" 73 8 "CG Times Bold" "CG Times Bold" "CG Times Italic" "CG Times Italic" "Univers" "Univers" "Univers Bold Condensed" "Univers Bold Condensed" "Garamond Halbfett" "Garamond Halbfett" "Courier Bold" "Courier Bold" "Univers Bold Italic" "Univers Bold Italic" "CG Times Bold Italic" "CG Times Bold Italic" "Univers Italic" "Univers Italic" "Garamond Antiqua" "Garamond Antiqua" "Arial" "Arial" "CG Times" "CG Times" "Times New Roman" "Times New Roman" "Univers Condensed Italic" "Univers Condensed Italic" "Univers Bold" "Univers Bold" "Univers Condensed" "Univers Condensed" "Arial Bold" "Arial Bold" "Univers Bold Condensed Italic" "Univers Bold Condensed Italic" "Garamond Kursiv Halbfett" "Garamond Kursiv Halbfett" "Times New Roman Bold" "Times New Roman Bold" "Courier" "Courier" "Arial Italic" "Arial Italic" "Arial Bold Italic" "Arial Bold Italic" "Courier Bold Italic" "Courier Bold Italic" "Garamond Kursiv" "Garamond Kursiv" "Courier Italic" "Courier Italic" "Times New Roman Bold Italic" "Times New Roman Bold Italic" "Times New Roman Italic" "Times New Roman Italic" "Chancery HC Bold" "Chancery HC Bold" "OCR-A" "OCR-A" "Helvetica" "Helvetica" "Arial Narrow Bold" "Arial Narrow Bold" "Helvetica Narrow Bold" "Helvetica Narrow Bold" "Palatino Bold" "Palatino Bold" "Courier New Bold" "Courier New Bold" "Helvetica Bold Oblique" "Helvetica Bold Oblique" "Helvetica Oblique" "Helvetica Oblique" "Palatino Roman" "Palatino Roman" "Bookman Old Style" "Bookman Old Style" "ITC Bookman Light" "ITC Bookman Light" "New Century Schoolbook Roman" "New Century Schoolbook Roman" "Times Roman" "Times Roman" "Arial Narrow Italic" "Arial Narrow Italic" "Helvetica Narrow Oblique" "Helvetica Narrow Oblique" "Helvetica Bold" "Helvetica Bold" "Arial Narrow" "Arial Narrow" "Helvetica Narrow" "Helvetica Narrow" "Arial Narrow Bold Italic" "Arial Narrow Bold Italic" "Helvetica Narrow Bold Oblique" "Helvetica Narrow Bold Oblique" "Palatino Bold Italic" "Palatino Bold Italic" "Bookman Old Style Bold" "Bookman Old Style Bold" "ITC Bookman Demi" "ITC Bookman Demi" "New Century Schoolbook Bold" "New Century Schoolbook Bold" "Times Bold" "Times Bold" "Century Schoolbook" "Century Schoolbook" "Century Schoolbook Bold" "Century Schoolbook Bold" "Courier New" "Courier New" "Line Printer" "Line Printer" "Century Schoolbook Bold Italic" "Century Schoolbook Bold Italic" "Courier Bold Oblique" "Courier Bold Oblique" "Courier New Bold Italic" "Courier New Bold Italic" "Palatino Italic" "Palatino Italic" "Century Schoolbook Italic" "Century Schoolbook Italic" "Courier Oblique" "Courier Oblique" "Courier New Italic" "Courier New Italic" "Bookman Old Style Bold Italic" "Bookman Old Style Bold Italic" "ITC Bookman Demi Italic" "ITC Bookman Demi Italic" "New Century Schoolbook Bold Italic" "New Century Schoolbook Bold Italic" "Times Bold Italic" "Times Bold Italic" "Bookman Old Style Italic" "Bookman Old Style Italic" "ITC Bookman Light Italic" "ITC Bookman Light Italic" "New Century Schoolbook Italic" "New Century Schoolbook Italic" "Times Italic" "Times Italic" ' 
      172 '0 1 0 1 0 "9" "" ' 
      175 "0 1 1 1 0 " 
      176 "0 1 1 1 0 " 
      177 "0 1 1 1 0 " 
      178 "0 1 1 1 0 " 
      179 "0 1 1 1 0 " 
      180 "0 0 1 1 0 " 
      181 "0 0 1 1 0 " 
      303 '0 1 0 1 0 "NOTEXT" "" ' 
      307 "0 1 1 0 0 " 
      355 "0 0 1 0 0 " 
      356 "0 1 0 0 0 1 " 
      360 "0 0 0 0 0 0 " 
      368 "0 1 0 0 0 0 " 
      369 '0 1 0 0 0 "10" ' 
      370 '0 1 0 0 0 "10" ' 
      404 '0 1 0 0 0 "2090" ' 
      405 '0 1 0 0 0 "3184" ' 
      406 '0 1 0 0 0 "300" ' 
      407 '0 1 0 0 0 "3000" ' 
      408 '0 1 0 0 0 "300" ' 
      409 '0 1 0 0 0 "3000" ' 
      410 '0 1 0 0 0 "300" ' 
      411 '0 1 0 0 0 "3000" ' 
      412 "0 1 0 0 0 1 " 
      413 '0 1 0 0 0 "LONGEDGE" ' 
      414 "0 1 0 0 0 0 " 
      415 '0 1 0 0 0 "FRONT" ' 
      419 "0 1 0 0 0 1 " 
      463 "0 1 0 0 0 0 " 
    }
    !

    !1 
    1 
    'OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
    {
      8 4 
      145 "0 1 1 1 0 " 
      146 "0 1 1 1 0 " 
      150 "0 1 1 1 0 " 
      151 "0 1 1 1 0 " 
    }
    '

    ! 1 "22:A102242ADCF643F49283B4A2FD6C3576" @ 
}
OBJECT ( TYPE="LAYOUT_FORMAT" , NAME="no print" , DELIM=@ )
{
  @  6 
    1 
    !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
    {
      8 53 
      1 '0 1 0 0 0 "no print" ' 
      2 "0 1 1 0 0 " 
      3 '0 1 0 0 0 "" ' 
      4 '0 1 0 0 0 "" ' 
      5 "0 0 0 0 0 0 " 
      6 "0 0 0 0 0 0 " 
      9 "0 0 1 0 0 " 
      10 '1 0 0 0 0 "13:BD6AEED138084CC6AB065CF9CE9A6F2F" ' 
      104 '0 1 0 0 0 "PrimaryInput.Header.dec_page_num = 999999" ' 
      109 "1 1 1 0 0 " 
      156 '0 1 0 0 0 "DPI300" ' 
      157 "0 1 1 1 0 " 
      158 '0 1 0 1 1 "SOLID" "" 17 3 2039 "SOLID" 2040 "DASH" 2041 "DOT" 2042 "DASHDOT" 2043 "DASHDOTDOT" 2044 "LONGDASH" 2045 "DOTDOT" 2046 "FIXED7" 2047 "FIXED8" 2048 "ADAPT1" 2049 "ADAPT2" 2050 "ADAPT3" 2051 "ADAPT4" 2052 "ADAPT5" 2053 "ADAPT6" 2054 "ADAPT7" 2055 "ADAPT8" ' 
      159 '0 1 1 1 1 4 3 2057 "BUTTED" 2058 "SQUARED" 2059 "ROUNDED" 2060 "TRIANGULAR" ' 
      160 "0 1 1 1 0 " 
      161 "0 1 1 1 0 " 
      162 '0 1 0 1 1 "NONE" "" 17 3 2062 "NONE" 2063 "USER" 2064 "HC" 2078 "DC" 2065 "HS" 2066 "VS" 2067 "TS" 2068 "BS" 2069 "WHITE" 2070 "GREY1" 2071 "GREY2" 2072 "GREY3" 2073 "GREY4" 2074 "GREY5" 2075 "GREY6" 2076 "GREY7" 2077 "BLACK" ' 
      163 "0 1 1 1 0 " 
      164 "0 1 1 1 0 " 
      165 "0 1 1 1 0 " 
      166 "0 1 1 1 0 " 
      167 "1 0 1 1 0 " 
      168 "0 1 1 1 0 " 
      169 "0 1 1 1 0 " 
      170 "0 1 1 1 0 " 
      171 '0 1 0 1 1 "Albertus Bold" "" 88 8 "Albertus Bold" "Albertus Bold" "CG Times Bold" "CG Times Bold" "CG Times Italic" "CG Times Italic" "Letter Gothic Italic" "Letter Gothic Italic" "Univers" "Univers" "Letter Gothic" "Letter Gothic" "Coronet" "Coronet" "CG Omega Bold" "CG Omega Bold" "CG Omega Italic" "CG Omega Italic" "Univers Bold Condensed" "Univers Bold Condensed" "Garamond Halbfett" "Garamond Halbfett" "Antique Olive Bold" "Antique Olive Bold" "Letter Gothic Bold" "Letter Gothic Bold" "Courier Bold" "Courier Bold" "Univers Bold Italic" "Univers Bold Italic" "Marigold" "Marigold" "CG Times Bold Italic" "CG Times Bold Italic" "CG Omega" "CG Omega" "Univers Italic" "Univers Italic" "Clarendon Condensed" "Clarendon Condensed" "Garamond Antiqua" "Garamond Antiqua" "Arial" "Arial" "CG Times" "CG Times" "Times New Roman" "Times New Roman" "Albertus" "Albertus" "Univers Condensed Italic" "Univers Condensed Italic" "Antique Olive" "Antique Olive" "Univers Bold" "Univers Bold" "Univers Condensed" "Univers Condensed" "Arial Bold" "Arial Bold" "Univers Bold Condensed Italic" "Univers Bold Condensed Italic" "Garamond Kursiv Halbfett" "Garamond Kursiv Halbfett" "Times New Roman Bold" "Times New Roman Bold" "Courier" "Courier" "Arial Italic" "Arial Italic" "Arial Bold Italic" "Arial Bold Italic" "Antique Olive Italic" "Antique Olive Italic" "Courier Bold Italic" "Courier Bold Italic" "Garamond Kursiv" "Garamond Kursiv" "Courier Italic" "Courier Italic" "Times New Roman Bold Italic" "Times New Roman Bold Italic" "Times New Roman Italic" "Times New Roman Italic" "CG Omega Bold Italic" "CG Omega Bold Italic" "Chancery HC Bold" "Chancery HC Bold" "OCR-A" "OCR-A" "Helvetica" "Helvetica" "Arial Narrow Bold" "Arial Narrow Bold" "Helvetica Narrow Bold" "Helvetica Narrow Bold" "Palatino Bold" "Palatino Bold" "Courier New Bold" "Courier New Bold" "Helvetica Bold Oblique" "Helvetica Bold Oblique" "Helvetica Oblique" "Helvetica Oblique" "Palatino Roman" "Palatino Roman" "Bookman Old Style" "Bookman Old Style" "ITC Bookman Light" "ITC Bookman Light" "New Century Schoolbook Roman" "New Century Schoolbook Roman" "Times Roman" "Times Roman" "Arial Narrow Italic" "Arial Narrow Italic" "Helvetica Narrow Oblique" "Helvetica Narrow Oblique" "Helvetica Bold" "Helvetica Bold" "Arial Narrow" "Arial Narrow" "Helvetica Narrow" "Helvetica Narrow" "Arial Narrow Bold Italic" "Arial Narrow Bold Italic" "Helvetica Narrow Bold Oblique" "Helvetica Narrow Bold Oblique" "Palatino Bold Italic" "Palatino Bold Italic" "Bookman Old Style Bold" "Bookman Old Style Bold" "ITC Bookman Demi" "ITC Bookman Demi" "New Century Schoolbook Bold" "New Century Schoolbook Bold" "Times Bold" "Times Bold" "Century Schoolbook" "Century Schoolbook" "Century Schoolbook Bold" "Century Schoolbook Bold" "Courier New" "Courier New" "Line Printer" "Line Printer" "Century Schoolbook Bold Italic" "Century Schoolbook Bold Italic" "Courier Bold Oblique" "Courier Bold Oblique" "Courier New Bold Italic" "Courier New Bold Italic" "Palatino Italic" "Palatino Italic" "Century Schoolbook Italic" "Century Schoolbook Italic" "Courier Oblique" "Courier Oblique" "Courier New Italic" "Courier New Italic" "Bookman Old Style Bold Italic" "Bookman Old Style Bold Italic" "ITC Bookman Demi Italic" "ITC Bookman Demi Italic" "New Century Schoolbook Bold Italic" "New Century Schoolbook Bold Italic" "Times Bold Italic" "Times Bold Italic" "Bookman Old Style Italic" "Bookman Old Style Italic" "ITC Bookman Light Italic" "ITC Bookman Light Italic" "New Century Schoolbook Italic" "New Century Schoolbook Italic" "Times Italic" "Times Italic" ' 
      172 '0 1 0 1 0 "10" "" ' 
      175 "0 1 1 1 0 " 
      176 "0 1 1 1 0 " 
      177 "0 1 1 1 0 " 
      178 "0 1 1 1 0 " 
      179 "0 1 1 1 0 " 
      180 "0 0 1 1 0 " 
      181 "0 0 1 1 0 " 
      303 '0 1 0 1 0 "NOTEXT" "" ' 
      307 "0 1 1 0 0 " 
      355 "0 0 1 0 0 " 
      356 "0 1 0 0 0 1 " 
      360 "0 0 0 0 0 0 " 
      368 "0 1 0 0 0 0 " 
      369 '0 1 0 0 0 "30" ' 
      370 '0 1 0 0 0 "30" ' 
      404 '0 1 0 0 0 "315" ' 
      405 '0 1 0 0 0 "3000" ' 
      406 '0 1 0 0 0 "300" ' 
      407 '0 1 0 0 0 "3000" ' 
      408 '0 1 0 0 0 "300" ' 
      409 '0 1 0 0 0 "3000" ' 
      410 '0 1 0 0 0 "300" ' 
      411 '0 1 0 0 0 "3000" ' 
      412 "0 1 1 0 0 " 
      419 "0 1 0 0 0 1 " 
      463 "0 1 0 0 0 0 " 
    }
    !

    !1 
    1 
    'OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
    {
      8 4 
      145 "0 1 1 1 0 " 
      146 "0 1 1 1 0 " 
      150 "0 1 1 1 0 " 
      151 "0 1 1 1 0 " 
    }
    '

    ! 1 "22:D4E34FB1859148128209C8A1B867B31E" @ 
}
OBJECT ( TYPE="LAYOUT_FORMAT" , NAME="shell2" , DELIM=@ )
{
  @  6 
    1 
    !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
    {
      8 53 
      1 '0 1 0 0 0 "shell2" ' 
      2 "0 1 1 0 0 " 
      3 '0 1 0 0 0 "" ' 
      4 '0 1 0 0 0 "" ' 
      5 "0 0 0 0 0 0 " 
      6 "0 0 0 0 0 0 " 
      9 "0 0 1 0 0 " 
      10 '1 0 0 0 0 "13:5F179E4C478144C7A62A140A782FCD9C" ' 
      104 '0 1 0 0 0 "" ' 
      109 "1 1 1 0 0 " 
      156 '0 1 0 0 0 "DPI300" ' 
      157 "0 1 1 1 0 " 
      158 '0 1 0 1 1 "SOLID" "" 17 3 2039 "SOLID" 2040 "DASH" 2041 "DOT" 2042 "DASHDOT" 2043 "DASHDOTDOT" 2044 "LONGDASH" 2045 "DOTDOT" 2046 "FIXED7" 2047 "FIXED8" 2048 "ADAPT1" 2049 "ADAPT2" 2050 "ADAPT3" 2051 "ADAPT4" 2052 "ADAPT5" 2053 "ADAPT6" 2054 "ADAPT7" 2055 "ADAPT8" ' 
      159 '0 1 1 1 1 4 3 2057 "BUTTED" 2058 "SQUARED" 2059 "ROUNDED" 2060 "TRIANGULAR" ' 
      160 "0 1 1 1 0 " 
      161 "0 1 1 1 0 " 
      162 '0 1 0 1 1 "NONE" "" 17 3 2062 "NONE" 2063 "USER" 2064 "HC" 2078 "DC" 2065 "HS" 2066 "VS" 2067 "TS" 2068 "BS" 2069 "WHITE" 2070 "GREY1" 2071 "GREY2" 2072 "GREY3" 2073 "GREY4" 2074 "GREY5" 2075 "GREY6" 2076 "GREY7" 2077 "BLACK" ' 
      163 "0 1 1 1 0 " 
      164 "0 1 1 1 0 " 
      165 "0 1 1 1 0 " 
      166 "0 1 1 1 0 " 
      167 "1 0 1 1 0 " 
      168 "0 1 1 1 0 " 
      169 "0 1 1 1 0 " 
      170 "0 1 1 1 0 " 
      171 '0 1 0 1 1 "Albertus Bold" "" 48 8 "Courier-Bold" "Courier-Bold" "Courier-BoldOblique" "Courier-BoldOblique" "Courier" "Courier" "Courier-Oblique" "Courier-Oblique" "Helvetica" "Helvetica" "Helvetica-Bold" "Helvetica-Bold" "Helvetica-BoldOblique" "Helvetica-BoldOblique" "Helvetica-Oblique" "Helvetica-Oblique" "Symbol" "Symbol" "Times-Bold" "Times-Bold" "Times-BoldItalic" "Times-BoldItalic" "Times-Italic" "Times-Italic" "Times-Roman" "Times-Roman" "Zapf-Dingbats" "Zapf-Dingbats" "Courier New Bold" "Courier New Bold" "Courier Bold Italic" "Courier Bold Italic" "Courier New Bold Italic" "Courier New Bold Italic" "Courier New" "Courier New" "Line Printer" "Line Printer" "Courier Italic" "Courier Italic" "Courier New Italic" "Courier New Italic" "Arial" "Arial" "Univers" "Univers" "Arial Bold" "Arial Bold" "Univers Bold" "Univers Bold" "Arial Bold Italic" "Arial Bold Italic" "Univers Bold Italic" "Univers Bold Italic" "Arial Italic" "Arial Italic" "Univers Italic" "Univers Italic" "CG Times Bold" "CG Times Bold" "Times New Roman Bold" "Times New Roman Bold" "CG Times Bold Italic" "CG Times Bold Italic" "Times New Roman Bold Italic" "Times New Roman Bold Italic" "CG Times Italic" "CG Times Italic" "Times New Roman Italic" "Times New Roman Italic" "CG Times" "CG Times" "Times New Roman" "Times New Roman" "Courier Bold" "Courier Bold" "Courier Bold Oblique" "Courier Bold Oblique" "Courier Oblique" "Courier Oblique" "Helvetica Bold" "Helvetica Bold" "Helvetica Bold Oblique" "Helvetica Bold Oblique" "Helvetica Oblique" "Helvetica Oblique" "Times Bold" "Times Bold" "Times Bold Italic" "Times Bold Italic" "Times Italic" "Times Italic" "Times Roman" "Times Roman" "ITC Zapf Dingbats" "ITC Zapf Dingbats" ' 
      172 '0 1 0 1 0 "10" "" ' 
      175 "0 1 1 1 0 " 
      176 "0 1 1 1 0 " 
      177 "0 1 1 1 0 " 
      178 "0 1 1 1 0 " 
      179 "0 1 1 1 0 " 
      180 "0 0 1 1 0 " 
      181 "0 0 1 1 0 " 
      303 '0 1 0 1 0 "NOTEXT" "" ' 
      307 "0 1 1 0 0 " 
      355 "0 0 1 0 0 " 
      356 "0 1 0 0 0 1 " 
      360 "0 0 0 0 0 0 " 
      368 "0 1 0 0 0 0 " 
      369 '0 1 0 0 0 "30" ' 
      370 '0 1 0 0 0 "30" ' 
      404 '0 1 0 0 0 "1931" ' 
      405 '0 1 0 0 0 "3000" ' 
      406 '0 1 0 0 0 "300" ' 
      407 '0 1 0 0 0 "3000" ' 
      408 '0 1 0 0 0 "300" ' 
      409 '0 1 0 0 0 "3000" ' 
      410 '0 1 0 0 0 "300" ' 
      411 '0 1 0 0 0 "3000" ' 
      412 "0 1 1 0 0 " 
      419 "0 1 0 0 0 1 " 
      463 "0 1 0 0 0 0 " 
    }
    !

    !1 
    1 
    'OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
    {
      8 4 
      145 "0 1 1 1 0 " 
      146 "0 1 1 1 0 " 
      150 "0 1 1 1 0 " 
      151 "0 1 1 1 0 " 
    }
    '

    ! 1 "22:944E1F4CE2054760B25789E90E4BD0DF" @ 
}
OBJECT ( TYPE="LAYOUT_FORMAT" , NAME="cu3404_p2" , DELIM=@ )
{
  @  6 
    1 
    !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
    {
      8 56 
      1 '0 1 0 0 0 "cu3404_p2" ' 
      2 "0 1 1 0 0 " 
      3 '0 1 0 0 0 "" ' 
      4 '0 1 0 0 0 "" ' 
      5 "0 0 0 0 0 0 " 
      6 "0 0 0 0 0 0 " 
      9 "0 0 1 0 0 " 
      10 '1 0 0 0 0 "13:A5D03710A5354459B5BF43EEAF2FEC53" ' 
      104 '0 1 0 0 0 "" ' 
      109 "1 1 1 0 0 " 
      156 '0 1 0 0 0 "DPI300" ' 
      157 "0 1 1 1 0 " 
      158 '0 1 0 1 1 "SOLID" "" 17 3 2039 "SOLID" 2040 "DASH" 2041 "DOT" 2042 "DASHDOT" 2043 "DASHDOTDOT" 2044 "LONGDASH" 2045 "DOTDOT" 2046 "FIXED7" 2047 "FIXED8" 2048 "ADAPT1" 2049 "ADAPT2" 2050 "ADAPT3" 2051 "ADAPT4" 2052 "ADAPT5" 2053 "ADAPT6" 2054 "ADAPT7" 2055 "ADAPT8" ' 
      159 '0 1 1 1 1 4 3 2057 "BUTTED" 2058 "SQUARED" 2059 "ROUNDED" 2060 "TRIANGULAR" ' 
      160 "0 1 1 1 0 " 
      161 "0 1 1 1 0 " 
      162 '0 1 0 1 1 "NONE" "" 17 3 2062 "NONE" 2063 "USER" 2064 "HC" 2078 "DC" 2065 "HS" 2066 "VS" 2067 "TS" 2068 "BS" 2069 "WHITE" 2070 "GREY1" 2071 "GREY2" 2072 "GREY3" 2073 "GREY4" 2074 "GREY5" 2075 "GREY6" 2076 "GREY7" 2077 "BLACK" ' 
      163 "0 1 1 1 0 " 
      164 "0 1 1 1 0 " 
      165 "0 1 1 1 0 " 
      166 "0 1 1 1 0 " 
      167 "1 0 1 1 0 " 
      168 "0 1 1 1 0 " 
      169 "0 1 1 1 0 " 
      170 "0 1 1 1 0 " 
      171 '0 1 0 1 1 "Helvetica" "" 88 8 "Albertus Bold" "Albertus Bold" "CG Times Bold" "CG Times Bold" "CG Times Italic" "CG Times Italic" "Letter Gothic Italic" "Letter Gothic Italic" "Univers" "Univers" "Letter Gothic" "Letter Gothic" "Coronet" "Coronet" "CG Omega Bold" "CG Omega Bold" "CG Omega Italic" "CG Omega Italic" "Univers Bold Condensed" "Univers Bold Condensed" "Garamond Halbfett" "Garamond Halbfett" "Antique Olive Bold" "Antique Olive Bold" "Letter Gothic Bold" "Letter Gothic Bold" "Courier Bold" "Courier Bold" "Univers Bold Italic" "Univers Bold Italic" "Marigold" "Marigold" "CG Times Bold Italic" "CG Times Bold Italic" "CG Omega" "CG Omega" "Univers Italic" "Univers Italic" "Clarendon Condensed" "Clarendon Condensed" "Garamond Antiqua" "Garamond Antiqua" "Arial" "Arial" "CG Times" "CG Times" "Times New Roman" "Times New Roman" "Albertus" "Albertus" "Univers Condensed Italic" "Univers Condensed Italic" "Antique Olive" "Antique Olive" "Univers Bold" "Univers Bold" "Univers Condensed" "Univers Condensed" "Arial Bold" "Arial Bold" "Univers Bold Condensed Italic" "Univers Bold Condensed Italic" "Garamond Kursiv Halbfett" "Garamond Kursiv Halbfett" "Times New Roman Bold" "Times New Roman Bold" "Courier" "Courier" "Arial Italic" "Arial Italic" "Arial Bold Italic" "Arial Bold Italic" "Antique Olive Italic" "Antique Olive Italic" "Courier Bold Italic" "Courier Bold Italic" "Garamond Kursiv" "Garamond Kursiv" "Courier Italic" "Courier Italic" "Times New Roman Bold Italic" "Times New Roman Bold Italic" "Times New Roman Italic" "Times New Roman Italic" "CG Omega Bold Italic" "CG Omega Bold Italic" "Chancery HC Bold" "Chancery HC Bold" "OCR-A" "OCR-A" "Helvetica" "Helvetica" "Arial Narrow Bold" "Arial Narrow Bold" "Helvetica Narrow Bold" "Helvetica Narrow Bold" "Palatino Bold" "Palatino Bold" "Courier New Bold" "Courier New Bold" "Helvetica Bold Oblique" "Helvetica Bold Oblique" "Helvetica Oblique" "Helvetica Oblique" "Palatino Roman" "Palatino Roman" "Bookman Old Style" "Bookman Old Style" "ITC Bookman Light" "ITC Bookman Light" "New Century Schoolbook Roman" "New Century Schoolbook Roman" "Times Roman" "Times Roman" "Arial Narrow Italic" "Arial Narrow Italic" "Helvetica Narrow Oblique" "Helvetica Narrow Oblique" "Helvetica Bold" "Helvetica Bold" "Arial Narrow" "Arial Narrow" "Helvetica Narrow" "Helvetica Narrow" "Arial Narrow Bold Italic" "Arial Narrow Bold Italic" "Helvetica Narrow Bold Oblique" "Helvetica Narrow Bold Oblique" "Palatino Bold Italic" "Palatino Bold Italic" "Bookman Old Style Bold" "Bookman Old Style Bold" "ITC Bookman Demi" "ITC Bookman Demi" "New Century Schoolbook Bold" "New Century Schoolbook Bold" "Times Bold" "Times Bold" "Century Schoolbook" "Century Schoolbook" "Century Schoolbook Bold" "Century Schoolbook Bold" "Courier New" "Courier New" "Line Printer" "Line Printer" "Century Schoolbook Bold Italic" "Century Schoolbook Bold Italic" "Courier Bold Oblique" "Courier Bold Oblique" "Courier New Bold Italic" "Courier New Bold Italic" "Palatino Italic" "Palatino Italic" "Century Schoolbook Italic" "Century Schoolbook Italic" "Courier Oblique" "Courier Oblique" "Courier New Italic" "Courier New Italic" "Bookman Old Style Bold Italic" "Bookman Old Style Bold Italic" "ITC Bookman Demi Italic" "ITC Bookman Demi Italic" "New Century Schoolbook Bold Italic" "New Century Schoolbook Bold Italic" "Times Bold Italic" "Times Bold Italic" "Bookman Old Style Italic" "Bookman Old Style Italic" "ITC Bookman Light Italic" "ITC Bookman Light Italic" "New Century Schoolbook Italic" "New Century Schoolbook Italic" "Times Italic" "Times Italic" ' 
      172 '0 1 0 1 0 "9" "" ' 
      175 "0 1 1 1 0 " 
      176 "0 1 1 1 0 " 
      177 "0 1 1 1 0 " 
      178 "0 1 1 1 0 " 
      179 "0 1 1 1 0 " 
      180 "0 0 1 1 0 " 
      181 "0 0 1 1 0 " 
      303 '0 1 0 1 0 "NOTEXT" "" ' 
      307 "0 1 1 0 0 " 
      355 "0 0 1 0 0 " 
      356 "0 1 0 0 0 1 " 
      360 "0 0 0 0 0 0 " 
      368 "0 1 0 0 0 0 " 
      369 '0 1 0 0 0 "10" ' 
      370 '0 1 0 0 0 "10" ' 
      404 '0 1 0 0 0 "2090" ' 
      405 '0 1 0 0 0 "3184" ' 
      406 '0 1 0 0 0 "300" ' 
      407 '0 1 0 0 0 "3000" ' 
      408 '0 1 0 0 0 "300" ' 
      409 '0 1 0 0 0 "3000" ' 
      410 '0 1 0 0 0 "300" ' 
      411 '0 1 0 0 0 "3000" ' 
      412 "0 1 0 0 0 1 " 
      413 '0 1 0 0 0 "LONGEDGE" ' 
      414 "0 1 0 0 0 0 " 
      415 '0 1 0 0 0 "BACK" ' 
      419 "0 1 0 0 0 1 " 
      463 "0 1 0 0 0 0 " 
    }
    !

    !1 
    1 
    'OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
    {
      8 4 
      145 "0 1 1 1 0 " 
      146 "0 1 1 1 0 " 
      150 "0 1 1 1 0 " 
      151 "0 1 1 1 0 " 
    }
    '

    ! 1 "22:FDEBB62CEFE14BB68EB2EA0B1812258B" @ 
}
OBJECT ( TYPE="DATAMAP" , NAME="Text Data Datamap" , DELIM=# )
{
  #  1 
    1 
    @OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
    {
      8 13 
      1 '0 1 0 0 0 "Text Data Datamap" ' 
      2 "0 1 1 0 0 " 
      3 !0 1 0 0 0 'SET TRACE FILE "~errors\error.log"SET TRACE MASK TRACEMASK("ALL")' ! 
      4 !0 1 0 0 0 'CLOSE "cu3404"' ! 
      5 "0 0 0 0 0 0 " 
      6 "0 0 0 0 0 0 " 
      9 "0 0 1 0 0 " 
      10 '1 0 0 0 0 "21:157ED034F5994892A5E494F128FF65B3" ' 
      104 "0 1 1 0 0 " 
      201 "0 0 0 0 0 1 " 
      203 "0 1 0 0 0 1 " 
      206 "0 0 1 0 0 " 
      223 "0 0 0 0 0 1 " 
    }
    @

    1 "22:DCADB21C1170429A92029F53B58C8557" # 
}
OBJECT ( TYPE="SECTION" , NAME="Header" , DELIM=# )
{
  #  8 114 0 "" 
    1 
    @OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
    {
      8 15 
      1 '0 1 0 0 0 "Header" ' 
      2 "0 1 1 0 0 " 
      3 '0 1 0 0 0 "" ' 
      4 !0 1 0 0 0 '//LET syscommand = SYSTEM("D:\Program Files\Traction Software\Batch & Print Pro\Batch And Print.exe D:\Documents and Settings\All Users\Application Data\Optio\OECI\7.7\images\DOC\HODEC199.doc")' ! 
      5 "0 0 0 0 0 0 " 
      6 "0 0 0 0 0 0 " 
      9 "0 0 1 0 0 " 
      10 '1 0 0 0 0 "22:DCADB21C1170429A92029F53B58C8557" ' 
      101 "0 0 0 0 0 720 " 
      104 "0 1 1 0 0 " 
      207 "0 1 0 0 0 255 " 
      208 '0 1 0 0 0 "None" ' 
      209 "0 1 0 0 0 0 " 
      212 '0 1 0 1 0 "1" "" ' 
      280 "0 1 0 0 0 1 " 
    }
    @

    3 @  OBJECT ( TYPE="ODElement" , NAME="" , DELIM=0 )
      {
        5 
        1 
        !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
        {
          8 26 
          1 '0 1 0 0 0 "form_type" ' 
          2 "0 1 1 0 0 " 
          3 "0 1 1 0 0 " 
          4 "0 1 1 0 0 " 
          5 "0 0 1 0 0 " 
          6 "0 0 1 0 0 " 
          9 "0 0 1 0 0 " 
          10 '1 0 0 0 0 "0:C29E87169540448991906C5D903F68FF" ' 
          186 '0 1 0 1 0 "4" "" ' 
          187 '0 1 0 1 0 "1" "" ' 
          188 '0 1 0 1 0 "10" "" ' 
          189 '0 1 0 1 0 "1" "" ' 
          190 "0 1 1 0 0 " 
          191 "1 1 0 0 0 0 " 
          192 "0 1 0 0 0 0 " 
          194 "0 0 0 0 0 0 " 
          197 "0 1 0 0 0 1 " 
          198 "0 1 0 0 0 0 " 
          308 '0 1 0 0 0 1 "C_NOTICE  " ' 
          352 '0 1 0 0 0 "PRUNE" ' 
          353 '0 1 0 0 0 "" ' 
          354 '0 1 0 0 0 "" ' 
          386 "0 0 0 0 0 0 " 
          387 "0 0 0 0 0 0 " 
          390 '0 1 0 0 0 "" ' 
          398 "1 0 1 0 0 " 
        }
        !

        101 "" 
      }
      @ @  OBJECT ( TYPE="ODElement" , NAME="" , DELIM=0 )
      {
        5 
        1 
        !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
        {
          8 26 
          1 '0 1 0 0 0 "dec_page_num" ' 
          2 "0 1 1 0 0 " 
          3 "0 1 1 0 0 " 
          4 "0 1 1 0 0 " 
          5 "0 0 1 0 0 " 
          6 "0 0 1 0 0 " 
          9 "0 0 1 0 0 " 
          10 '1 0 0 0 0 "0:442EB0431DB84B09A8A94A38C59A262C" ' 
          186 '0 1 0 1 0 "27" "" ' 
          187 '0 1 0 1 0 "1" "" ' 
          188 '0 1 0 1 0 "6" "" ' 
          189 '0 1 0 1 0 "1" "" ' 
          190 "0 1 1 0 0 " 
          191 "1 1 0 0 0 0 " 
          192 "0 1 0 0 0 0 " 
          194 "0 0 0 0 0 0 " 
          197 "0 1 0 0 0 1 " 
          198 "0 1 0 0 0 0 " 
          308 '0 1 0 0 0 1 "000002" ' 
          352 '0 1 0 0 0 "PRUNE" ' 
          353 '0 1 0 0 0 "" ' 
          354 '0 1 0 0 0 "" ' 
          386 "0 0 0 0 0 0 " 
          387 "0 0 0 0 0 0 " 
          390 '0 1 0 0 0 "" ' 
          398 "1 0 1 0 0 " 
        }
        !

        101 "" 
      }
      @ @  OBJECT ( TYPE="ODElement" , NAME="" , DELIM=0 )
      {
        5 
        1 
        !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
        {
          8 26 
          1 '0 1 0 0 0 "print_dest1" ' 
          2 "0 1 1 0 0 " 
          3 "0 1 1 0 0 " 
          4 "0 1 1 0 0 " 
          5 "0 0 1 0 0 " 
          6 "0 0 1 0 0 " 
          9 "0 0 1 0 0 " 
          10 '1 0 0 0 0 "0:DC44CDADD104450A9276CADFB8473AAF" ' 
          186 '0 1 0 1 0 "33" "" ' 
          187 '0 1 0 1 0 "1" "" ' 
          188 '0 1 0 1 0 "50" "" ' 
          189 '0 1 0 1 0 "1" "" ' 
          190 "0 1 1 0 0 " 
          191 "1 1 0 0 0 0 " 
          192 "0 1 0 0 0 0 " 
          194 "0 0 0 0 0 0 " 
          197 "0 1 0 0 0 1 " 
          198 "0 1 0 0 0 0 " 
          308 '0 1 0 0 0 1 "\\PAPERMILL\D$\BILLS\20210318\3SD45281.PDF        " ' 
          352 '0 1 0 0 0 "PRUNE" ' 
          353 '0 1 0 0 0 "" ' 
          354 '0 1 0 0 0 "" ' 
          386 "0 0 0 0 0 0 " 
          387 "0 0 0 0 0 0 " 
          390 '0 1 0 0 0 "" ' 
          398 "1 0 1 0 0 " 
        }
        !

        101 "" 
      }
      @ # 
}
OBJECT ( TYPE="SECTION" , NAME="Background" , DELIM=# )
{
  #  8 113 0 "" 
    1 
    !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
    {
      8 25 
      1 '0 1 0 0 0 "Background" ' 
      2 "0 1 1 0 0 " 
      3 "0 1 1 0 0 " 
      4 "0 1 1 0 0 " 
      5 "0 0 0 0 0 0 " 
      6 "0 0 0 0 0 0 " 
      9 "0 0 1 0 0 " 
      10 '1 0 0 0 0 "22:A102242ADCF643F49283B4A2FD6C3576" ' 
      101 "0 0 0 0 0 0 " 
      104 "0 1 1 0 0 " 
      156 '1 0 0 0 0 "DPI300" ' 
      207 "0 1 0 0 0 255 " 
      208 '0 1 0 0 0 "None" ' 
      209 "1 1 0 0 0 0 " 
      212 '0 1 0 1 0 "1" "" ' 
      214 "0 1 1 1 0 " 
      328 "0 1 0 0 0 1 " 
      375 '0 1 0 0 0 "0" ' 
      391 '1 1 0 0 0 "None" ' 
      403 '0 1 0 0 0 "ALL" ' 
      416 "0 1 0 0 0 1 " 
      443 '0 0 0 0 0 "1" ' 
      444 '0 0 0 0 0 "-1" ' 
      445 '0 0 0 0 0 "-1" ' 
      446 '0 0 0 0 0 "-1" ' 
    }
    !

    1 @  OBJECT ( TYPE="ODElement" , NAME="" , DELIM=0 )
      {
        5 
        1 
        !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
        {
          8 27 
          1 '0 1 0 0 0 "Image1" ' 
          2 "0 1 1 0 0 " 
          3 "0 1 1 0 0 " 
          4 "0 1 1 0 0 " 
          5 "0 0 1 0 0 " 
          6 "0 0 1 0 0 " 
          9 "0 0 1 0 0 " 
          10 '1 0 0 0 0 "0:AC5DD34AF9F24282BC9CD1A97A385399" ' 
          186 '0 1 0 1 0 "0" "" ' 
          187 '0 1 0 1 0 "0" "" ' 
          188 '1 1 0 1 0 "2546" "" ' 
          189 '1 1 0 1 0 "3296" "" ' 
          190 "0 1 1 0 0 " 
          194 "0 1 0 0 0 1 " 
          197 "0 1 0 0 0 1 " 
          287 '0 1 0 1 0 "NO" "" ' 
          290 '0 1 0 1 0 "NO" "" ' 
          292 '0 1 0 1 0 "0" "" ' 
          293 "0 1 0 0 0 0 " 
          298 "0 1 1 1 0 " 
          307 "0 1 1 0 0 " 
          317 '0 1 0 1 0 "CU3404-1.tif" "" ' 
          318 '0 1 0 1 0 "NO" "" ' 
          358 "0 0 0 0 0 1 " 
          421 '0 1 0 0 0 "Normal" ' 
          422 '1 1 0 0 0 "100" ' 
          423 '1 1 0 0 0 "100" ' 
        }
        !

        109 "" 
      }
      @ # 
}
OBJECT ( TYPE="SECTION" , NAME="Background1" , DELIM=@ )
{
  @  8 113 0 "None" 
    1 
    !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
    {
      8 25 
      1 '0 1 0 0 0 "Background1" ' 
      2 "0 1 1 0 0 " 
      3 "0 1 1 0 0 " 
      4 "0 1 1 0 0 " 
      5 "0 0 0 0 0 0 " 
      6 "0 0 0 0 0 0 " 
      9 "0 0 1 0 0 " 
      10 '1 0 0 0 0 "22:D4E34FB1859148128209C8A1B867B31E" ' 
      101 "0 0 1 0 0 " 
      104 "0 1 1 0 0 " 
      156 '1 0 0 0 0 "DPI300" ' 
      207 "0 1 0 0 0 255 " 
      208 '0 1 0 0 0 "None" ' 
      209 "1 1 0 0 0 0 " 
      212 '0 1 0 1 0 "0" "" ' 
      214 "0 1 1 1 0 " 
      328 "0 1 0 0 0 1 " 
      375 '0 1 0 0 0 "0" ' 
      391 '1 1 0 0 0 "None" ' 
      403 '0 1 0 0 0 "ALL" ' 
      416 "0 1 0 0 0 1 " 
      443 '0 0 0 0 0 "-1" ' 
      444 '0 0 0 0 0 "-1" ' 
      445 '0 0 0 0 0 "-1" ' 
      446 '0 0 0 0 0 "-1" ' 
    }
    !

    0 @ 
}
OBJECT ( TYPE="SECTION" , NAME="Background2" , DELIM=@ )
{
  @  8 113 0 "None" 
    1 
    !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
    {
      8 25 
      1 '0 1 0 0 0 "Background2" ' 
      2 "0 1 1 0 0 " 
      3 "0 1 1 0 0 " 
      4 "0 1 1 0 0 " 
      5 "0 0 0 0 0 0 " 
      6 "0 0 0 0 0 0 " 
      9 "0 0 1 0 0 " 
      10 '1 0 0 0 0 "22:944E1F4CE2054760B25789E90E4BD0DF" ' 
      101 "0 0 1 0 0 " 
      104 "0 1 1 0 0 " 
      156 '1 0 0 0 0 "DPI300" ' 
      207 "0 1 0 0 0 255 " 
      208 '0 1 0 0 0 "None" ' 
      209 "1 1 0 0 0 0 " 
      212 '0 1 0 1 0 "0" "" ' 
      214 "0 1 1 1 0 " 
      328 "0 1 0 0 0 1 " 
      375 '0 1 0 0 0 "0" ' 
      391 '1 1 0 0 0 "None" ' 
      403 '0 1 0 0 0 "ALL" ' 
      416 "0 1 0 0 0 1 " 
      443 '0 0 0 0 0 "-1" ' 
      444 '0 0 0 0 0 "-1" ' 
      445 '0 0 0 0 0 "-1" ' 
      446 '0 0 0 0 0 "-1" ' 
    }
    !

    0 @ 
}
OBJECT ( TYPE="SECTION" , NAME="Background3" , DELIM=# )
{
  #  8 113 0 "None" 
    1 
    !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
    {
      8 25 
      1 '0 1 0 0 0 "Background3" ' 
      2 "0 1 1 0 0 " 
      3 "0 1 1 0 0 " 
      4 "0 1 1 0 0 " 
      5 "0 0 0 0 0 0 " 
      6 "0 0 0 0 0 0 " 
      9 "0 0 1 0 0 " 
      10 '1 0 0 0 0 "22:FDEBB62CEFE14BB68EB2EA0B1812258B" ' 
      101 "0 0 0 0 0 0 " 
      104 "0 1 1 0 0 " 
      156 '1 0 0 0 0 "DPI300" ' 
      207 "0 1 0 0 0 255 " 
      208 '0 1 0 0 0 "None" ' 
      209 "1 1 0 0 0 0 " 
      212 '0 1 0 1 0 "1" "" ' 
      214 "0 1 1 1 0 " 
      328 "0 1 0 0 0 1 " 
      375 '0 1 0 0 0 "0" ' 
      391 '1 1 0 0 0 "None" ' 
      403 '0 1 0 0 0 "ALL" ' 
      416 "0 1 0 0 0 1 " 
      443 '0 0 0 0 0 "1" ' 
      444 '0 0 0 0 0 "-1" ' 
      445 '0 0 0 0 0 "-1" ' 
      446 '0 0 0 0 0 "-1" ' 
    }
    !

    1 @  OBJECT ( TYPE="ODElement" , NAME="" , DELIM=0 )
      {
        5 
        1 
        !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
        {
          8 27 
          1 '0 1 0 0 0 "Image1" ' 
          2 "0 1 1 0 0 " 
          3 "0 1 1 0 0 " 
          4 "0 1 1 0 0 " 
          5 "0 0 1 0 0 " 
          6 "0 0 1 0 0 " 
          9 "0 0 1 0 0 " 
          10 '1 0 0 0 0 "0:2C1BF53F6E934A43B876E41E351B1936" ' 
          186 '0 1 0 1 0 "0" "" ' 
          187 '0 1 0 1 0 "-1" "" ' 
          188 '1 1 0 1 0 "2546" "" ' 
          189 '1 1 0 1 0 "3296" "" ' 
          190 "0 1 1 0 0 " 
          194 "0 1 0 0 0 1 " 
          197 "0 1 0 0 0 1 " 
          287 '0 1 0 1 0 "NO" "" ' 
          290 '0 1 0 1 0 "NO" "" ' 
          292 '0 1 0 1 0 "0" "" ' 
          293 "0 1 0 0 0 0 " 
          298 "0 1 1 1 0 " 
          307 "0 1 1 0 0 " 
          317 '0 1 0 1 0 "CU3404-2.tif" "" ' 
          318 '0 1 0 1 0 "NO" "" ' 
          358 "0 0 0 0 0 1 " 
          421 '0 1 0 0 0 "Normal" ' 
          422 '1 1 0 0 0 "100" ' 
          423 '1 1 0 0 0 "100" ' 
        }
        !

        109 "" 
      }
      @ # 
}
OBJECT ( TYPE="FLOWTOOL_CONDITIONAL" , NAME="If Condition" , DELIM=@ )
{
  @  2 
    1 
    !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
    {
      8 8 
      1 '0 1 0 0 0 "If Condition" ' 
      2 "0 1 1 0 0 " 
      3 "0 1 1 0 0 " 
      4 "0 1 1 0 0 " 
      5 "0 0 0 0 0 0 " 
      6 "0 0 0 0 0 0 " 
      9 "0 0 1 0 0 " 
      10 '1 0 0 0 0 "16:D33150A015D34A67B87E1CC312925891" ' 
    }
    !

    5 
    '  1 "output_dev = ""printer""" "Printer" ' 
    '  1 "output_dev = ""PDF""" "Pdf" ' 
    '  1 "output_dev = ""Email""" "Email" ' 
    '  1 "output_dev = ""PCL""" "Pcl" ' 
    '  1 "" "no print" ' 
  @ 
}
OBJECT ( TYPE="DEFCON_PROCESS_FLOW" , NAME="" , DELIM=^ )
{
  ^  1 "" 
    'OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
    {
      8 5 
      101 "0 0 0 0 0 100 " 
      102 "0 0 0 0 0 100 " 
      103 "0 0 1 0 0 " 
      284 "0 0 0 0 0 369 " 
      285 "0 0 0 0 0 110 " 
    }
    ' 
    0 1 
    OBJECT ( TYPE="PROCESS_FLOW_CHILD" , NAME="" , DELIM=% )
    {
      %  1 "16:D33150A015D34A67B87E1CC312925891" 
        !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
        {
          8 5 
          101 "0 0 0 0 0 270 " 
          102 "0 0 0 0 0 232 " 
          103 '0 0 0 0 0 "if.ico" ' 
          284 "0 0 1 0 0 " 
          285 "0 0 1 0 0 " 
        }
        ! 
        0 5 
        OBJECT ( TYPE="PROCESS_FLOW_CHILD" , NAME="" , DELIM=$ )
        {
          $  1 "7:F0014345DD2B4BE59E15D46AD152682F" 
            !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
            {
              8 5 
              101 "0 0 0 0 0 148 " 
              102 "0 0 0 0 0 325 " 
              103 '0 0 0 0 0 "printer.ico" ' 
              284 "0 0 1 0 0 " 
              285 "0 0 1 0 0 " 
            }
            ! 
            0 1 
            OBJECT ( TYPE="PROCESS_FLOW_CHILD" , NAME="" , DELIM=# )
            {
              #  1 "13:F1772AAB3E02421AAC10CDBE39E7BB4E" 
                !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
                {
                  8 6 
                  101 "0 0 0 0 0 139 " 
                  102 "0 0 0 0 0 402 " 
                  103 '0 0 0 0 0 "blankdoc.ico" ' 
                  183 "0 1 0 0 0 1 " 
                  284 "0 0 1 0 0 " 
                  285 "0 0 1 0 0 " 
                }
                ! 
                1 @  1 
                  1 
                  !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
                  {
                    8 4 
                    145 '0 1 0 1 0 "Lower" "" ' 
                    146 "0 1 1 1 0 " 
                    150 "0 1 1 1 0 " 
                    151 "0 1 1 1 0 " 
                  }
                  !

                @ 1 
                OBJECT ( TYPE="PROCESS_FLOW_CHILD" , NAME="" , DELIM=@ )
                {
                  @  1 "13:A5D03710A5354459B5BF43EEAF2FEC53" 
                    !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
                    {
                      8 6 
                      101 "0 0 0 0 0 143 " 
                      102 "0 0 0 0 0 473 " 
                      103 '0 0 0 0 0 "blankdoc.ico" ' 
                      183 "0 1 0 0 0 1 " 
                      284 "0 0 1 0 0 " 
                      285 "0 0 1 0 0 " 
                    }
                    ! 
                    1 !  1 
                      1 
                      'OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
                      {
                        8 5 
                        145 "0 1 1 1 0 " 
                        146 "0 1 1 1 0 " 
                        150 "0 1 1 1 0 " 
                        151 "0 1 1 1 0 " 
                        222 "0 1 1 0 0 " 
                      }
                      '

                    ! 0 @ 
                }
                
              # 
            }
            
          $ 
        }
        
        OBJECT ( TYPE="PROCESS_FLOW_CHILD" , NAME="" , DELIM=# )
        {
          #  1 "5:F6173733D467442D81D450B05513E316" 
            !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
            {
              8 5 
              101 "0 0 0 0 0 210 " 
              102 "0 0 0 0 0 323 " 
              103 '0 0 0 0 0 "file.ico" ' 
              284 "0 0 1 0 0 " 
              285 "0 0 1 0 0 " 
            }
            ! 
            0 1 
            OBJECT ( TYPE="PROCESS_FLOW_CHILD" , NAME="" , DELIM=@ )
            {
              @  1 "13:5F179E4C478144C7A62A140A782FCD9C" 
                !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
                {
                  8 6 
                  101 "0 0 0 0 0 210 " 
                  102 "0 0 0 0 0 399 " 
                  103 '0 0 0 0 0 "blankdoc.ico" ' 
                  183 "0 1 0 0 0 1 " 
                  284 "0 0 1 0 0 " 
                  285 "0 0 1 0 0 " 
                }
                ! 
                1 !  1 
                  1 
                  'OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
                  {
                    8 4 
                    145 "0 1 1 1 0 " 
                    146 "0 1 1 1 0 " 
                    150 "0 1 1 1 0 " 
                    151 "0 1 1 1 0 " 
                  }
                  '

                ! 0 @ 
            }
            
          # 
        }
        
        OBJECT ( TYPE="PROCESS_FLOW_CHILD" , NAME="" , DELIM=# )
        {
          #  1 "9:4E1DA4C1A9EB4258BDEF63AFEB0779F1" 
            !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
            {
              8 5 
              101 "0 0 0 0 0 272 " 
              102 "0 0 0 0 0 320 " 
              103 '0 0 0 0 0 "email.ico" ' 
              284 "0 0 1 0 0 " 
              285 "0 0 1 0 0 " 
            }
            ! 
            0 1 
            OBJECT ( TYPE="PROCESS_FLOW_CHILD" , NAME="" , DELIM=@ )
            {
              @  1 "13:F1772AAB3E02421AAC10CDBE39E7BB4E" 
                !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
                {
                  8 6 
                  101 "0 0 0 0 0 273 " 
                  102 "0 0 0 0 0 401 " 
                  103 '0 0 0 0 0 "blankdoc.ico" ' 
                  183 "0 1 0 0 0 1 " 
                  284 "0 0 1 0 0 " 
                  285 "0 0 1 0 0 " 
                }
                ! 
                1 !  1 
                  1 
                  'OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
                  {
                    8 4 
                    145 "0 1 1 1 0 " 
                    146 "0 1 1 1 0 " 
                    150 "0 1 1 1 0 " 
                    151 "0 1 1 1 0 " 
                  }
                  '

                ! 0 @ 
            }
            
          # 
        }
        
        OBJECT ( TYPE="PROCESS_FLOW_CHILD" , NAME="" , DELIM=# )
        {
          #  1 "5:E4D03F72AFE54C5CBCEF92524E449F5B" 
            !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
            {
              8 5 
              101 "0 0 0 0 0 334 " 
              102 "0 0 0 0 0 321 " 
              103 '0 0 0 0 0 "file.ico" ' 
              284 "0 0 1 0 0 " 
              285 "0 0 1 0 0 " 
            }
            ! 
            0 1 
            OBJECT ( TYPE="PROCESS_FLOW_CHILD" , NAME="" , DELIM=@ )
            {
              @  1 "13:F1772AAB3E02421AAC10CDBE39E7BB4E" 
                !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
                {
                  8 6 
                  101 "0 0 0 0 0 334 " 
                  102 "0 0 0 0 0 400 " 
                  103 '0 0 0 0 0 "blankdoc.ico" ' 
                  183 "0 1 0 0 0 1 " 
                  284 "0 0 1 0 0 " 
                  285 "0 0 1 0 0 " 
                }
                ! 
                1 !  1 
                  1 
                  'OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
                  {
                    8 4 
                    145 "0 1 1 1 0 " 
                    146 "0 1 1 1 0 " 
                    150 "0 1 1 1 0 " 
                    151 "0 1 1 1 0 " 
                  }
                  '

                ! 0 @ 
            }
            
          # 
        }
        
        OBJECT ( TYPE="PROCESS_FLOW_CHILD" , NAME="" , DELIM=# )
        {
          #  1 "7:C4296FD975E344BDA28990356B37DAFD" 
            !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
            {
              8 5 
              101 "0 0 0 0 0 385 " 
              102 "0 0 0 0 0 321 " 
              103 '0 0 0 0 0 "printer.ico" ' 
              284 "0 0 1 0 0 " 
              285 "0 0 1 0 0 " 
            }
            ! 
            0 1 
            OBJECT ( TYPE="PROCESS_FLOW_CHILD" , NAME="" , DELIM=@ )
            {
              @  1 "13:BD6AEED138084CC6AB065CF9CE9A6F2F" 
                !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
                {
                  8 6 
                  101 "0 0 0 0 0 409 " 
                  102 "0 0 0 0 0 399 " 
                  103 '0 0 0 0 0 "blankdoc.ico" ' 
                  183 "0 1 0 0 0 1 " 
                  284 "0 0 1 0 0 " 
                  285 "0 0 1 0 0 " 
                }
                ! 
                1 !  1 
                  1 
                  'OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
                  {
                    8 5 
                    145 "0 1 1 1 0 " 
                    146 "0 1 1 1 0 " 
                    150 "0 1 1 1 0 " 
                    151 "0 1 1 1 0 " 
                    222 "0 1 1 0 0 " 
                  }
                  '

                ! 0 @ 
            }
            
          # 
        }
        
      % 
    }
    
  ^ 
}
OBJECT ( TYPE="BASE_DOCUMENT" , NAME="" , DELIM=@ )
{
  @  5 0 
    1 
    !OBJECT ( TYPE="PropertyCollection" , NAME="" , DELIM=0 )
    {
      8 28 
      1 '0 1 0 0 0 "cu3404" ' 
      2 "0 1 1 0 0 " 
      3 '0 1 0 0 0 "" ' 
      4 "0 1 1 0 0 " 
      5 "0 0 1 0 0 " 
      6 "0 0 1 0 0 " 
      9 "0 0 1 0 0 " 
      10 '1 0 0 0 0 "25:2A95C484E82C4AB28E19AE6141320CE5" ' 
      336 "0 1 1 0 0 " 
      337 "0 1 1 0 0 " 
      338 '0 1 0 0 0 "7/7/2004" ' 
      339 '0 1 0 0 0 "5/25/2023" ' 
      340 "0 1 1 0 0 " 
      341 "0 1 1 0 0 " 
      342 "0 1 1 0 0 " 
      343 "0 1 1 0 0 " 
      344 "0 1 1 0 0 " 
      345 "0 1 1 0 0 " 
      346 '0 1 0 0 0 3 "pagenum" "output_dev" "print_dest" ' 
      377 "0 1 1 0 0 " 
      379 "0 0 1 0 0 " 
      425 "0 1 1 0 0 " 
      426 "0 0 1 0 0 " 
      427 "0 1 1 0 0 " 
      428 "0 1 1 0 0 " 
      429 "0 0 1 0 0 " 
      430 "0 1 1 0 0 " 
      462 "0 0 1 0 0 " 
    }
    !

    0 @ 
}
