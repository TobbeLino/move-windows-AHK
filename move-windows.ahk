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
    WinGet, activeWinId, ID, A
    
    if (!activeWinId) {
        return
    }
    
    ; Get monitor information
    SysGet, monitorCount, MonitorCount
    
    if (monitorCount < 2) {
        return ; Only one monitor, nothing to do
    }
    
    ; Find which monitor the window is currently on
    currentMonitor := GetMonitorIndexFromWindow(activeWinId)
    
    ; Calculate next monitor (wrap around)
    nextMonitor := Mod(currentMonitor, monitorCount) + 1
    
    ; Move window to target monitor
    MoveWindowToMonitor(activeWinId, currentMonitor, nextMonitor)
}

; Function to move window to previous monitor
MoveWindowToPreviousMonitor() {
    WinGet, activeWinId, ID, A
    
    if (!activeWinId) {
        return
    }
    
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
    
    ; Move window to target monitor
    MoveWindowToMonitor(activeWinId, currentMonitor, previousMonitor)
}

; Helper function to move window to a specific monitor
MoveWindowToMonitor(winId, currentMonitor, targetMonitor) {
    ; Get current window position
    WinGetPos, winX, winY, winWidth, winHeight, ahk_id %winId%
    
    ; Get the work area of the target monitor
    SysGet, mon, MonitorWorkArea, %targetMonitor%
    
    ; Get the work area of the current monitor
    SysGet, currentMon, MonitorWorkArea, %currentMonitor%
    
    ; Calculate relative position within current monitor
    currentMonWidth := currentMonRight - currentMonLeft
    currentMonHeight := currentMonBottom - currentMonTop
    
    ; Check for zero dimensions to avoid division by zero
    if (currentMonWidth = 0) {
        currentMonWidth := 1
    }
    if (currentMonHeight = 0) {
        currentMonHeight := 1
    }
    
    relativeX := (winX - currentMonLeft) / currentMonWidth
    relativeY := (winY - currentMonTop) / currentMonHeight
    
    ; Calculate new position on target monitor
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
    WinMove, ahk_id %winId%, , %newX%, %newY%
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
