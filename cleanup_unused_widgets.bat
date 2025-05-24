@echo off
setlocal enabledelayedexpansion

echo ========================================
echo SPACED LEARNING - CLEANUP UNUSED WIDGETS
echo ========================================
echo.
echo WARNING: This script will move 76 unused widget files to backup
echo Press Ctrl+C to cancel or any key to continue...
pause > nul

:: Initialize counters
set /a TOTAL_FILES=76
set /a PROCESSED=0
set /a SUCCESS=0
set /a FAILED=0

:: Create backup folder with timestamp
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "BACKUP_DIR=backup_widgets_%dt:~0,4%%dt:~4,2%%dt:~6,2%_%dt:~8,2%%dt:~10,2%%dt:~12,2%"
mkdir "%BACKUP_DIR%" 2>nul
echo.
echo [INFO] Created backup folder: %BACKUP_DIR%
echo.

:: Create log file
set "LOG_FILE=%BACKUP_DIR%\cleanup_log.txt"
echo Spaced Learning Widget Cleanup Log > "%LOG_FILE%"
echo Started: %date% %time% >> "%LOG_FILE%"
echo ======================================== >> "%LOG_FILE%"
echo. >> "%LOG_FILE%"

:: Function to process file
goto :start

:process_file
    set "FILE_PATH=%~1"
    set "FILE_NAME=%~2"
    set /a PROCESSED+=1
    
    :: Calculate percentage
    set /a PERCENT=!PROCESSED!*100/!TOTAL_FILES!
    
    :: Display progress
    echo [!PROCESSED!/!TOTAL_FILES!] !PERCENT!%% - Processing: !FILE_NAME!
    
    if exist "!FILE_PATH!" (
        move "!FILE_PATH!" "%BACKUP_DIR%\" >nul 2>&1
        if !errorlevel! equ 0 (
            echo   [OK] Moved successfully
            echo [SUCCESS] !FILE_PATH! >> "%LOG_FILE%"
            set /a SUCCESS+=1
        ) else (
            echo   [ERROR] Failed to move file
            echo [FAILED] !FILE_PATH! - Error: !errorlevel! >> "%LOG_FILE%"
            set /a FAILED+=1
        )
    ) else (
        echo   [SKIP] File not found
        echo [NOT FOUND] !FILE_PATH! >> "%LOG_FILE%"
        set /a SUCCESS+=1
    )
    exit /b

:start

:: Animation widgets (11 files)
echo.
echo ========================================
echo [1/9] REMOVING ANIMATION WIDGETS (11 files)
echo ========================================
echo -------------------------------------------- >> "%LOG_FILE%"
echo Animation Widgets >> "%LOG_FILE%"
echo -------------------------------------------- >> "%LOG_FILE%"

call :process_file "lib\presentation\widgets\animations\slt_bounce_animation.dart" "slt_bounce_animation.dart"
call :process_file "lib\presentation\widgets\animations\slt_flare_animation.dart" "slt_flare_animation.dart"
call :process_file "lib\presentation\widgets\animations\slt_flip_animation.dart" "slt_flip_animation.dart"
call :process_file "lib\presentation\widgets\animations\slt_hero_transition.dart" "slt_hero_transition.dart"
call :process_file "lib\presentation\widgets\animations\slt_lottie_animation.dart" "slt_lottie_animation.dart"
call :process_file "lib\presentation\widgets\animations\slt_pulse_animation.dart" "slt_pulse_animation.dart"
call :process_file "lib\presentation\widgets\animations\slt_rotation_animation.dart" "slt_rotation_animation.dart"
call :process_file "lib\presentation\widgets\animations\slt_scale_animation.dart" "slt_scale_animation.dart"
call :process_file "lib\presentation\widgets\animations\slt_slide_transition.dart" "slt_slide_transition.dart"
call :process_file "lib\presentation\widgets\animations\slt_typing_animation.dart" "slt_typing_animation.dart"
call :process_file "lib\presentation\widgets\animations\slt_fade_animation.dart" "slt_fade_animation.dart"

:: Chart widgets (11 files)
echo.
echo ========================================
echo [2/9] REMOVING CHART WIDGETS (11 files)
echo ========================================
echo. >> "%LOG_FILE%"
echo -------------------------------------------- >> "%LOG_FILE%"
echo Chart Widgets >> "%LOG_FILE%"
echo -------------------------------------------- >> "%LOG_FILE%"

call :process_file "lib\presentation\widgets\charts\slt_area_chart.dart" "slt_area_chart.dart"
call :process_file "lib\presentation\widgets\charts\slt_bubble_chart.dart" "slt_bubble_chart.dart"
call :process_file "lib\presentation\widgets\charts\slt_candlestick_chart.dart" "slt_candlestick_chart.dart"
call :process_file "lib\presentation\widgets\charts\slt_gauge_chart.dart" "slt_gauge_chart.dart"
call :process_file "lib\presentation\widgets\charts\slt_heat_map.dart" "slt_heat_map.dart"
call :process_file "lib\presentation\widgets\charts\slt_histogram.dart" "slt_histogram.dart"
call :process_file "lib\presentation\widgets\charts\slt_pie_chart.dart" "slt_pie_chart.dart"
call :process_file "lib\presentation\widgets\charts\slt_radar_chart.dart" "slt_radar_chart.dart"
call :process_file "lib\presentation\widgets\charts\slt_scatter_plot.dart" "slt_scatter_plot.dart"
call :process_file "lib\presentation\widgets\charts\slt_stacked_bar_chart.dart" "slt_stacked_bar_chart.dart"
call :process_file "lib\presentation\widgets\charts\slt_data_table.dart" "slt_data_table.dart"

:: Media widgets (9 files)
echo.
echo ========================================
echo [3/9] REMOVING MEDIA WIDGETS (9 files)
echo ========================================
echo. >> "%LOG_FILE%"
echo -------------------------------------------- >> "%LOG_FILE%"
echo Media Widgets >> "%LOG_FILE%"
echo -------------------------------------------- >> "%LOG_FILE%"

call :process_file "lib\presentation\widgets\media\slt_audio_player.dart" "slt_audio_player.dart"
call :process_file "lib\presentation\widgets\media\slt_camera_view.dart" "slt_camera_view.dart"
call :process_file "lib\presentation\widgets\media\slt_crop_image_view.dart" "slt_crop_image_view.dart"
call :process_file "lib\presentation\widgets\media\slt_document_viewer.dart" "slt_document_viewer.dart"
call :process_file "lib\presentation\widgets\media\slt_file_preview.dart" "slt_file_preview.dart"
call :process_file "lib\presentation\widgets\media\slt_media_uploader.dart" "slt_media_uploader.dart"
call :process_file "lib\presentation\widgets\media\slt_qr_scanner.dart" "slt_qr_scanner.dart"
call :process_file "lib\presentation\widgets\media\slt_thumbnail.dart" "slt_thumbnail.dart"
call :process_file "lib\presentation\widgets\media\slt_video_player.dart" "slt_video_player.dart"

:: Auth widgets (9 files)
echo.
echo ========================================
echo [4/9] REMOVING AUTH WIDGETS (9 files)
echo ========================================
echo. >> "%LOG_FILE%"
echo -------------------------------------------- >> "%LOG_FILE%"
echo Auth Widgets >> "%LOG_FILE%"
echo -------------------------------------------- >> "%LOG_FILE%"

call :process_file "lib\presentation\widgets\auth\slt_auth_guard.dart" "slt_auth_guard.dart"
call :process_file "lib\presentation\widgets\auth\slt_auth_screen.dart" "slt_auth_screen.dart"
call :process_file "lib\presentation\widgets\auth\slt_biometric_auth.dart" "slt_biometric_auth.dart"
call :process_file "lib\presentation\widgets\auth\slt_password_reset.dart" "slt_password_reset.dart"
call :process_file "lib\presentation\widgets\auth\slt_permission_manager.dart" "slt_permission_manager.dart"
call :process_file "lib\presentation\widgets\auth\slt_permission_request.dart" "slt_permission_request.dart"
call :process_file "lib\presentation\widgets\auth\slt_role_based_access.dart" "slt_role_based_access.dart"
call :process_file "lib\presentation\widgets\auth\slt_secure_storage.dart" "slt_secure_storage.dart"
call :process_file "lib\presentation\widgets\auth\slt_verification_code.dart" "slt_verification_code.dart"

:: Navigation widgets (11 files)
echo.
echo ========================================
echo [5/9] REMOVING NAVIGATION WIDGETS (11 files)
echo ========================================
echo. >> "%LOG_FILE%"
echo -------------------------------------------- >> "%LOG_FILE%"
echo Navigation Widgets >> "%LOG_FILE%"
echo -------------------------------------------- >> "%LOG_FILE%"

call :process_file "lib\presentation\widgets\navigation\slt_bottom_action_bar.dart" "slt_bottom_action_bar.dart"
call :process_file "lib\presentation\widgets\navigation\slt_breadcrumb.dart" "slt_breadcrumb.dart"
call :process_file "lib\presentation\widgets\navigation\slt_drawer.dart" "slt_drawer.dart"
call :process_file "lib\presentation\widgets\navigation\slt_navigation_rail.dart" "slt_navigation_rail.dart"
call :process_file "lib\presentation\widgets\navigation\slt_nested_navigation.dart" "slt_nested_navigation.dart"
call :process_file "lib\presentation\widgets\navigation\slt_nested_tab_bar.dart" "slt_nested_tab_bar.dart"
call :process_file "lib\presentation\widgets\navigation\slt_page_indicator.dart" "slt_page_indicator.dart"
call :process_file "lib\presentation\widgets\navigation\slt_quick_action_bar.dart" "slt_quick_action_bar.dart"
call :process_file "lib\presentation\widgets\navigation\slt_side_menu.dart" "slt_side_menu.dart"
call :process_file "lib\presentation\widgets\navigation\slt_bottom_sheet.dart" "slt_bottom_sheet.dart"
call :process_file "lib\presentation\widgets\navigation\slt_page_wrapper.dart" "slt_page_wrapper.dart"

:: Lists widgets (8 files)
echo.
echo ========================================
echo [6/9] REMOVING LIST WIDGETS (8 files)
echo ========================================
echo. >> "%LOG_FILE%"
echo -------------------------------------------- >> "%LOG_FILE%"
echo List Widgets >> "%LOG_FILE%"
echo -------------------------------------------- >> "%LOG_FILE%"

call :process_file "lib\presentation\widgets\lists\slt_filterable_list.dart" "slt_filterable_list.dart"
call :process_file "lib\presentation\widgets\lists\slt_infinite_grid_view.dart" "slt_infinite_grid_view.dart"
call :process_file "lib\presentation\widgets\lists\slt_list_section_header.dart" "slt_list_section_header.dart"
call :process_file "lib\presentation\widgets\lists\slt_responsive_data_table.dart" "slt_responsive_data_table.dart"
call :process_file "lib\presentation\widgets\lists\slt_selectable_list_tile.dart" "slt_selectable_list_tile.dart"
call :process_file "lib\presentation\widgets\lists\slt_sortable_data_table.dart" "slt_sortable_data_table.dart"
call :process_file "lib\presentation\widgets\lists\slt_sticky_header_list.dart" "slt_sticky_header_list.dart"
call :process_file "lib\presentation\widgets\lists\slt_swipeable_list_tile.dart" "slt_swipeable_list_tile.dart"

:: Filters widgets (8 files)
echo.
echo ========================================
echo [7/9] REMOVING FILTER WIDGETS (8 files)
echo ========================================
echo. >> "%LOG_FILE%"
echo -------------------------------------------- >> "%LOG_FILE%"
echo Filter Widgets >> "%LOG_FILE%"
echo -------------------------------------------- >> "%LOG_FILE%"

call :process_file "lib\presentation\widgets\filters\slt_advanced_filter_panel.dart" "slt_advanced_filter_panel.dart"
call :process_file "lib\presentation\widgets\filters\slt_category_filter.dart" "slt_category_filter.dart"
call :process_file "lib\presentation\widgets\filters\slt_date_range_filter.dart" "slt_date_range_filter.dart"
call :process_file "lib\presentation\widgets\filters\slt_filter_bar.dart" "slt_filter_bar.dart"
call :process_file "lib\presentation\widgets\filters\slt_filter_bottom_sheet.dart" "slt_filter_bottom_sheet.dart"
call :process_file "lib\presentation\widgets\filters\slt_filter_chip_group.dart" "slt_filter_chip_group.dart"
call :process_file "lib\presentation\widgets\filters\slt_search_history.dart" "slt_search_history.dart"
call :process_file "lib\presentation\widgets\filters\slt_search_suggestion.dart" "slt_search_suggestion.dart"

:: Common widgets (8 files)
echo.
echo ========================================
echo [8/9] REMOVING COMMON WIDGETS (8 files)
echo ========================================
echo. >> "%LOG_FILE%"
echo -------------------------------------------- >> "%LOG_FILE%"
echo Common Widgets >> "%LOG_FILE%"
echo -------------------------------------------- >> "%LOG_FILE%"

call :process_file "lib\presentation\widgets\common\slt_bottom_action_bar.dart" "slt_bottom_action_bar.dart"
call :process_file "lib\presentation\widgets\common\slt_grid_layout.dart" "slt_grid_layout.dart"
call :process_file "lib\presentation\widgets\common\slt_learning_footer.dart" "slt_learning_footer.dart"
call :process_file "lib\presentation\widgets\common\slt_modal_bottom_sheet.dart" "slt_modal_bottom_sheet.dart"
call :process_file "lib\presentation\widgets\common\slt_responsive_layout.dart" "slt_responsive_layout.dart"
call :process_file "lib\presentation\widgets\common\slt_screen_header.dart" "slt_screen_header.dart"
call :process_file "lib\presentation\widgets\common\slt_sliver.dart" "slt_sliver.dart"
call :process_file "lib\presentation\widgets\common\slt_status_bar.dart" "slt_status_bar.dart"

:: Cards widgets (2 files)
echo.
echo ========================================
echo [9/9] REMOVING CARD WIDGETS (2 files)
echo ========================================
echo. >> "%LOG_FILE%"
echo -------------------------------------------- >> "%LOG_FILE%"
echo Card Widgets >> "%LOG_FILE%"
echo -------------------------------------------- >> "%LOG_FILE%"

call :process_file "lib\presentation\widgets\cards\slt_gradient_card.dart" "slt_gradient_card.dart"
call :process_file "lib\presentation\widgets\cards\slt_grid_tile.dart" "slt_grid_tile.dart"

:: Summary
echo.
echo. >> "%LOG_FILE%"
echo ======================================== >> "%LOG_FILE%"
echo Summary >> "%LOG_FILE%"
echo ======================================== >> "%LOG_FILE%"
echo Total Files: !TOTAL_FILES! >> "%LOG_FILE%"
echo Successfully Moved: !SUCCESS! >> "%LOG_FILE%"
echo Failed: !FAILED! >> "%LOG_FILE%"
echo Completed: %date% %time% >> "%LOG_FILE%"

echo.
echo ========================================
echo CLEANUP COMPLETED!
echo ========================================
echo.
echo SUMMARY:
echo   Total Files: !TOTAL_FILES!
echo   Successfully Moved: !SUCCESS!
echo   Failed: !FAILED!
echo.
echo Files moved to: %BACKUP_DIR%
echo Log file saved: %LOG_FILE%
echo.
echo ========================================
echo IMPORTANT NEXT STEPS:
echo ========================================
echo 1. Run: flutter clean
echo 2. Run: flutter pub get
echo 3. Update barrel exports and imports
echo 4. Run: flutter analyze
echo 5. Test the application thoroughly
echo.
echo NOTE: Backup can be deleted after confirming app works correctly.
echo.
pause