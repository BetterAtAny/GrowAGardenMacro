#Requires AutoHotkey v2
#SingleInstance Force

Seeds := [11, 12, 13, 14, 15, 16, 17, 18] 
Gears := [1, 2, 3, 4, 5, 6, 7, 8, 9] 

PrivateServer := 'https://www.roblox.com/share?code=311fe0cc8e2c22428e1a85c0e37e003e&type=Server'

ActivateRobloxWindow() {
    if (WinExist("ahk_exe RobloxPlayerBeta.exe")) {
        WinActivate("ahk_exe RobloxPlayerBeta.exe") 
    } else {
        Sleep(1)
    }
}

CheckGameLoaded() {
    Pixel := PixelGetColor(998, 127)
    if (Pixel == 0xFFFFFF) {
        return true 
    } else {
        return false 
    }
}

SendKeystroke(Keystroke, EndDelay := 50, PressDelay := 30, Amount := 1, KeyDelay := 0) {
    if (Keystroke ~= "^[A-Z]$") {
        Keystroke := Chr(Ord(Keystroke) + 32)
    }

    if (PressDelay > 0) {
        Loop Amount {
            Send('{' Keystroke ' Down}')
            Sleep(PressDelay) 
            Send('{' Keystroke ' Up}')
            Sleep(KeyDelay)
        }
    } else {
        Loop Amount {
            Send('{' Keystroke '}')
        }
    }
    Sleep(EndDelay)
}


SafeClick(X_Coordinate, Y_Coordinate, Click_Amount := 1, Click_Delay := 50) {
    MouseMove(X_Coordinate, Y_Coordinate)
    Sleep(250)
    Click(X_Coordinate + 1, Y_Coordinate + 1) 
    Sleep(1)
    
    Loop Click_Amount {
        Click(X_Coordinate, Y_Coordinate)
        Sleep(Click_Delay)
    }
} 

SafeScroll(Direction, Amount := 1, Delay := 5) {
    Loop Amount {
        Click(Direction) 
        Sleep(Delay)
    }
}

SafeDrag(X_Start, Y_Start, X_End, Y_End, Button := 'Right', Speed := 2) {
    SafeClick(X_Start, Y_Start)
    Sleep(1)
    MouseClick(Button, X_Start, Y_Start,,,'Down')
    Sleep(1)
    MouseClick(Button, X_End, Y_End,,,'Up')
}  

ChangeCameraMode() {
    SendKeystroke('Escape', 500) 
    SendKeystroke('Tab', 350) 
    SendKeystroke('Down') 
    SendKeystroke('Right',,,2)
    SendKeystroke('Escape', 500) 
}

UniversalTeleport(Option) {
    SendKeystroke('\',,,,25) 
    SendKeystroke('Right',,,Option+2,25)
    SendKeystroke('Enter',,,,25) 
    SendKeystroke('\',,,,25)
} 

CameraAlignment() {
    SafeDrag(960, 200, 960, 400)
}

CharacterAligment() {
    ChangeCameraMode() 
    SendKeystroke('\')
    SendKeystroke('Right',,,3,50)
    Loop 5 {
        SendKeystroke('Enter')
        SendKeystroke('Right',,,2,50) 
        SendKeystroke('Enter')
        SendKeystroke('Left',,,2,50)
    } 
    SendKeystroke('\')
    ChangeCameraMode() 
}

ZoomAlignment() {
    SafeClick(960, 200,,50)
    SafeScroll('WU', 20, 25)
    SafeScroll('WD', 6, 25)
}

Alignment() {
    CameraAlignment() 
    Sleep(500)
    CharacterAligment() 
    Sleep(500)
    ZoomAlignment()
}

StartPressingE() {
    SetTimer(PressE, 1) ; Press E every 100 ms
}

StopPressingE() {
    SetTimer(PressE, 0) ; Stop the timer
}

PressE() {
    SendKeystroke("E")
}

TomatoCollection() {
    SafeScroll('WD', 4, 25)
    UniversalTeleport(2)
    StartPressingE()
    Loop 2 {
        UniversalTeleport(2)
        SendKeystroke('S',,1250)
        SendKeystroke('W',,900)
        SendKeystroke('D',,2350)
        SendKeystroke('S',,900)
    }
    SafeScroll('WU', 4, 25)
    StopPressingE() 
}

DepositSummer() {
    UniversalTeleport(1)
    SendKeystroke("D",,8922)
    SendKeystroke("S",,515)
    SendKeystroke("D",,1553)
    SendKeystroke("W",,1000)
    Sleep(125)
    SendKeystroke('E')
    Sleep(1000)
    SafeClick(1350, 530)
}

SummerHarvest() {
    TomatoCollection() 
    DepositSummer() 
}

NavigateShopUI(Indexes) {
    CurrentIndex := 0

    SendKeystroke('\') 
    SendKeystroke('Left')
    SendKeystroke('Right')

    for Index in Indexes {
        Index := Index - 1 
        if Index > CurrentIndex {
            SendKeystroke('Down',,,(Index - CurrentIndex), 125) 
        } else if Index < CurrentIndex {
            SendKeystroke('Up',,,(CurrentIndex - Index), 125)
        }

        SendKeystroke('Enter') 
        SendKeystroke('Down') 
        SendKeystroke('Enter',,,20,5) 
        SendKeystroke('Up') 
        SendKeystroke('Enter') 

        CurrentIndex := Index 
        Sleep(250)
    }

    SendKeystroke('Up',,,(CurrentIndex),125)
    SendKeystroke('Enter',,,2,250)
    SendKeystroke('\') 
} 

CloseShop() {
    MouseMove(1275, 250)
    SafeClick(1275, 250)
}

SeedShopCycle(Seeds) {
    UniversalTeleport(1) 
    Sleep(500)
    SendKeystroke('E',2500) 
    NavigateShopUI(Seeds)
    CloseShop() 
}

GearShopCycle(Gears) {
    SendKeystroke('2') 
    SafeClick(960, 400)
    Sleep(500) 
    SendKeystroke('E') 
    Sleep(1500) 
    SafeClick(1450, 440)
    Sleep(50)
    SafeClick(1475, 425)
    Sleep(2500)
    NavigateShopUI(Gears)
    CloseShop() 
} 

SetInventory() {
    SendKeystroke('``') 
    SendKeystroke('\')
    SendKeystroke('Down',,,3) 
    SendKeystroke('Enter',,,2)
    SendKeystroke('Right') 
    SendKeystroke('Enter')
    SendKeystroke('Down',,,3)
    SendKeystroke('Enter')
    Send('Recall Wrench') 
    Sleep(100)
    SendKeystroke('Enter')
    SendKeystroke('Down',,,2)
    SendKeystroke('Up',,,2) 
    SendKeystroke('Enter')
    SendKeystroke('Down')
    SendKeystroke('Right')
    SendKeystroke('Enter')
    SendKeystroke('\')
    SendKeystroke('``')
}

FirstRun() {
    ActivateRobloxWindow() 
    Alignment() 
    SetInventory() 
    SeedShopCycle(Seeds) 
    Sleep(500)
    GearShopCycle(Gears)  
}

MainLoop() {
    If (!WinExist('ahk_exe RobloxPlayerBeta.exe')) {
        JoinGame() 
        FirstRun()
    } else {
        FirstRun()
    }

    Loop {
        if (PixelGetColor(800, 450) == 0x393B3D) {
            if WinExist('ahk_exe RobloxPlayerBeta.exe') {
                WinClose() 
            }
            JoinGame() 
            Alignment() 
            SetInventory() 
        }

        If (!WinExist('ahk_exe RobloxPlayerBeta.exe')) {
            JoinGame() 
            Alignment() 
            SetInventory()
        }
        nowTime := FormatTime(, "mm:ss")
        if (nowTime = "00:00") {
            Alignment() 
            start := A_TickCount
            while (A_TickCount - start < 600000) {
                SummerHarvest()
                Sleep(5)
            }
        }

        if (Mod(A_Min, 5) = 0 && A_Sec = 0) {
            SeedShopCycle(Seeds) 
            GearShopCycle(Gears) 
        }
    }
    start := A_TickCount
    while (A_TickCount - start < 600000) {
        SummerHarvest()
    }
}


JoinGame() {
    CheckCount := 0
    Run('msedge.exe "' . PrivateServer . '"')
    Run('notepad.exe')
    Loop {
        if WinExist('Roblox') {
            WinActivate('Roblox')
            WinMaximize("Roblox") ; Maximize Roblox
            break
        } else {
            if (CheckCount < 10) {
                Sleep(1500) 
            } else {
                CheckCount := 0 
                Run(PrivateServer)
            }
        }
    }

    Loop {
        if (PixelGetColor(1075, 120) == 0x7A3E23) {
            if WinExist('ahk_exe notepad.exe') {
                WinClose()
            }

            while WinExist("ahk_exe msedge.exe") {
                WinClose("ahk_exe msedge.exe")
                Sleep(100)
            }
            break
        } else {
            if WinExist('ahk_exe notepad.exe') {
                WinActivate()
            }
            ActivateRobloxWindow()
            Sleep(1000)
        }
    }
}

F7::{
    ExitApp
}

MainLoop() 
