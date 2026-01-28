; AutoHotKey Script to Move Windows Between Monitors
; Author: TobbeLino
; Description: Move the active window between monitors using keyboard shortcuts
; Shortcuts:
;   Win+Shift+Right: Move window to next monitor (right)
;   Win+Shift+Left: Move window to previous monitor (left)

#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

; Move window to next monitor (right)
#+Right::
    MoveWindowToNextMonitor()
return

; Move window to previous monitor (left)
#+Left::
    MoveWindowToPreviousMonitor()
return

; Function to move window to next monitor
MoveWindowToNextMonitor() {
    WinGetActiveTitle, activeTitle
    WinGet, activeWinId, ID, %activeTitle%
    
    if (!activeWinId) {
        return
    }
    
    ; Get current window position
    WinGetPos, winX, winY, winWidth, winHeight, ahk_id %activeWinId%
    
    ; Get monitor information
    SysGet, monitorCount, MonitorCount
    
    if (monitorCount < 2) {
        return ; Only one monitor, nothing to do
    }
    
    ; Find which monitor the window is currently on
    currentMonitor := GetMonitorIndexFromWindow(activeWinId)
    
    ; Calculate next monitor (wrap around)
    nextMonitor := Mod(currentMonitor, monitorCount) + 1
    
    ; Get the work area of the next monitor
    SysGet, mon, MonitorWorkArea, %nextMonitor%
    
    ; Calculate new position (try to maintain relative position)
    SysGet, currentMon, MonitorWorkArea, %currentMonitor%
    
    ; Calculate relative position within current monitor
    relativeX := (winX - currentMonLeft) / (currentMonRight - currentMonLeft)
    relativeY := (winY - currentMonTop) / (currentMonBottom - currentMonTop)
    
    ; Calculate new position on next monitor
    newX := monLeft + (relativeX * (monRight - monLeft))
    newY := monTop + (relativeY * (monBottom - monTop))
    
    ; Ensure window fits on the new monitor
    if (newX + winWidth > monRight) {
        newX := monRight - winWidth
    }
    if (newY + winHeight > monBottom) {
        newY := monBottom - winHeight
    }
    if (newX < monLeft) {
        newX := monLeft
    }
    if (newY < monTop) {
        newY := monTop
    }
    
    ; Move the window
    WinMove, ahk_id %activeWinId%, , %newX%, %newY%
}

; Function to move window to previous monitor
MoveWindowToPreviousMonitor() {
    WinGetActiveTitle, activeTitle
    WinGet, activeWinId, ID, %activeTitle%
    
    if (!activeWinId) {
        return
    }
    
    ; Get current window position
    WinGetPos, winX, winY, winWidth, winHeight, ahk_id %activeWinId%
    
    ; Get monitor information
    SysGet, monitorCount, MonitorCount
    
    if (monitorCount < 2) {
        return ; Only one monitor, nothing to do
    }
    
    ; Find which monitor the window is currently on
    currentMonitor := GetMonitorIndexFromWindow(activeWinId)
    
    ; Calculate previous monitor (wrap around)
    previousMonitor := currentMonitor - 1
    if (previousMonitor < 1) {
        previousMonitor := monitorCount
    }
    
    ; Get the work area of the previous monitor
    SysGet, mon, MonitorWorkArea, %previousMonitor%
    
    ; Calculate new position (try to maintain relative position)
    SysGet, currentMon, MonitorWorkArea, %currentMonitor%
    
    ; Calculate relative position within current monitor
    relativeX := (winX - currentMonLeft) / (currentMonRight - currentMonLeft)
    relativeY := (winY - currentMonTop) / (currentMonBottom - currentMonTop)
    
    ; Calculate new position on previous monitor
    newX := monLeft + (relativeX * (monRight - monLeft))
    newY := monTop + (relativeY * (monBottom - monTop))
    
    ; Ensure window fits on the new monitor
    if (newX + winWidth > monRight) {
        newX := monRight - winWidth
    }
    if (newY + winHeight > monBottom) {
        newY := monBottom - winHeight
    }
    if (newX < monLeft) {
        newX := monLeft
    }
    if (newY < monTop) {
        newY := monTop
    }
    
    ; Move the window
    WinMove, ahk_id %activeWinId%, , %newX%, %newY%
}

; Helper function to determine which monitor a window is on
GetMonitorIndexFromWindow(winId) {
    WinGetPos, winX, winY, winWidth, winHeight, ahk_id %winId%
    
    ; Calculate center point of window
    winCenterX := winX + (winWidth / 2)
    winCenterY := winY + (winHeight / 2)
    
    SysGet, monitorCount, MonitorCount
    
    Loop, %monitorCount% {
        SysGet, mon, MonitorWorkArea, %A_Index%
        
        if (winCenterX >= monLeft && winCenterX <= monRight && winCenterY >= monTop && winCenterY <= monBottom) {
            return A_Index
        }
    }
    
    ; If not found, return 1 (primary monitor)
    return 1
}
