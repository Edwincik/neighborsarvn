local Airflow = loadstring(game:HttpGet("https://raw.githubusercontent.com/PookiePepelsss/Airflow-UI/refs/heads/main/Source.luau"))()

Airflow:LoadFont({ Name = "ValleySans" })

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")
local MarketplaceService = game:GetService("MarketplaceService")

local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()

local CREATOR = "Arven"

local Theme = { Binds = {}, Default = "Toz Pembe & Bebek Mavisi" }
Theme.Presets = {
    ["Toz Pembe & Bebek Mavisi"] = {
        BG = Color3.fromRGB(22, 19, 29), PANEL = Color3.fromRGB(29, 26, 38), CARD = Color3.fromRGB(37, 33, 48),
        HOVER = Color3.fromRGB(50, 45, 64), CHIP = Color3.fromRGB(55, 50, 71), STROKE = Color3.fromRGB(78, 70, 96),
        TEXT = Color3.fromRGB(247, 240, 244), DIM = Color3.fromRGB(176, 166, 190), FAINT = Color3.fromRGB(120, 111, 138),
        ACCENT = Color3.fromRGB(226, 166, 183), ACCENT2 = Color3.fromRGB(163, 212, 241), DARK = Color3.fromRGB(28, 22, 34),
        GOOD = Color3.fromRGB(158, 226, 206), WARN = Color3.fromRGB(245, 208, 150), BAD = Color3.fromRGB(236, 128, 150),
    },
    ["Toz Pembe"] = {
        BG = Color3.fromRGB(26, 19, 23), PANEL = Color3.fromRGB(34, 26, 31), CARD = Color3.fromRGB(43, 34, 40),
        HOVER = Color3.fromRGB(57, 45, 53), CHIP = Color3.fromRGB(63, 50, 59), STROKE = Color3.fromRGB(88, 70, 80),
        TEXT = Color3.fromRGB(248, 240, 243), DIM = Color3.fromRGB(184, 165, 174), FAINT = Color3.fromRGB(128, 108, 118),
        ACCENT = Color3.fromRGB(226, 166, 183), ACCENT2 = Color3.fromRGB(243, 207, 217), DARK = Color3.fromRGB(32, 22, 27),
        GOOD = Color3.fromRGB(176, 226, 200), WARN = Color3.fromRGB(245, 208, 150), BAD = Color3.fromRGB(232, 112, 130),
    },
    ["Bebek Mavisi"] = {
        BG = Color3.fromRGB(17, 21, 29), PANEL = Color3.fromRGB(23, 28, 38), CARD = Color3.fromRGB(30, 36, 48),
        HOVER = Color3.fromRGB(41, 49, 64), CHIP = Color3.fromRGB(46, 54, 70), STROKE = Color3.fromRGB(64, 75, 96),
        TEXT = Color3.fromRGB(240, 246, 250), DIM = Color3.fromRGB(160, 174, 192), FAINT = Color3.fromRGB(106, 120, 140),
        ACCENT = Color3.fromRGB(163, 212, 241), ACCENT2 = Color3.fromRGB(205, 232, 250), DARK = Color3.fromRGB(18, 24, 34),
        GOOD = Color3.fromRGB(158, 226, 206), WARN = Color3.fromRGB(245, 208, 150), BAD = Color3.fromRGB(236, 128, 150),
    },
    ["Orijinal (Mor)"] = {
        BG = Color3.fromRGB(15, 15, 19), PANEL = Color3.fromRGB(21, 21, 27), CARD = Color3.fromRGB(29, 29, 36),
        HOVER = Color3.fromRGB(40, 40, 49), CHIP = Color3.fromRGB(43, 43, 53), STROKE = Color3.fromRGB(54, 54, 66),
        TEXT = Color3.fromRGB(240, 240, 247), DIM = Color3.fromRGB(138, 138, 153), FAINT = Color3.fromRGB(92, 92, 107),
        ACCENT = Color3.fromRGB(235, 199, 246), ACCENT2 = Color3.fromRGB(120, 140, 255), DARK = Color3.fromRGB(20, 20, 26),
        GOOD = Color3.fromRGB(88, 214, 141), WARN = Color3.fromRGB(245, 190, 90), BAD = Color3.fromRGB(236, 94, 94),
    },
}
Theme.Order = { "Toz Pembe & Bebek Mavisi", "Toz Pembe", "Bebek Mavisi", "Orijinal (Mor)" }
Theme.Pal = Theme.Presets[Theme.Default]
function Theme.Bind(inst, prop, key)
    table.insert(Theme.Binds, { inst = inst, prop = prop, key = key })
end
local ACCENT = Theme.Pal.ACCENT

function Theme.DrawIcon(parent, kind, color, px, filled)
    local old = parent:FindFirstChild("HxIcon")
    if old then old:Destroy() end
    px = px or 14
    local z = (parent:IsA("GuiObject") and parent.ZIndex or 1) + 1
    local root = Instance.new("Frame")
    root.Name = "HxIcon"
    root.BackgroundTransparency = 1
    root.BorderSizePixel = 0
    root.Active = false
    root.AnchorPoint = Vector2.new(0.5, 0.5)
    root.Position = UDim2.new(0.5, 0, 0.5, 0)
    root.Size = UDim2.new(0, px, 0, px)
    root.ZIndex = z
    root.Parent = parent
    local h = px / 2
    local function bar(cx, cy, w, hgt, rot)
        local f = Instance.new("Frame")
        f.AnchorPoint = Vector2.new(0.5, 0.5)
        f.Position = UDim2.new(0, cx, 0, cy)
        f.Size = UDim2.new(0, w, 0, hgt)
        f.Rotation = rot or 0
        f.BackgroundColor3 = color
        f.BorderSizePixel = 0
        f.ZIndex = z
        f.Parent = root
        return f
    end
    local function round(f, r)
        local c = Instance.new("UICorner")
        c.CornerRadius = r or UDim.new(1, 0)
        c.Parent = f
    end
    local function ring(cx, cy, d, th)
        local f = bar(cx, cy, d, d, 0)
        f.BackgroundTransparency = 1
        round(f)
        local s = Instance.new("UIStroke")
        s.Color = color
        s.Thickness = th
        s.Parent = f
        return f
    end
    if kind == "star" then
        local R = px * 0.5
        local pts = {}
        for i = 0, 4 do
            local a = math.rad(-90 + 72 * i)
            pts[i] = Vector2.new(h + R * math.cos(a), h + R * math.sin(a) + 0.5)
        end
        local th = filled and 3 or 1.5
        for i = 0, 4 do
            local a, b = pts[i], pts[(i + 2) % 5]
            local d = b - a
            bar((a.X + b.X) / 2, (a.Y + b.Y) / 2, d.Magnitude + 1, th, math.deg(math.atan2(d.Y, d.X)))
        end
        if filled then round(bar(h, h + 0.8, px * 0.42, px * 0.42, 0)) end
    elseif kind == "heart" then
        local s = px * 0.46
        local c = Vector2.new(h, h + px * 0.1)
        bar(c.X, c.Y, s, s, 45)
        round(bar(c.X - s * 0.354, c.Y - s * 0.354, s, s, 0))
        round(bar(c.X + s * 0.354, c.Y - s * 0.354, s, s, 0))
    elseif kind == "diamond" then
        bar(h, h, px * 0.62, px * 0.62, 45)
    elseif kind == "x" then
        bar(h, h, px * 1.05, 2, 45)
        bar(h, h, px * 1.05, 2, -45)
    elseif kind == "search" then
        ring(h - px * 0.1, h - px * 0.1, px * 0.62, 2)
        bar(h + px * 0.3, h + px * 0.3, px * 0.38, 2.2, 45)
    elseif kind == "refresh" then
        ring(h, h, px * 0.74, 2)
        bar(h + px * 0.3, h - px * 0.3, px * 0.26, px * 0.26, 45)
    elseif kind == "grip" then
        for i = 1, 3 do
            local d = px * 0.22 * i
            local c = px - d * 0.7071
            bar(c, c, d * 1.2, 1.8, -45)
        end
    end
    return root
end

local Connections = {}
local function Connect(signal, fn)
    local c = signal:Connect(fn)
    table.insert(Connections, c)
    return c
end

local function Notify(title, content, kind)
    Airflow:Notify({ Title = title, Content = content, Icon = "bell", Type = kind or "Info", Duration = 3 })
end

local function GuiParent()
    local ok, parent = pcall(function() return gethui and gethui() end)
    if ok and parent then return parent end
    return CoreGui
end

local function GetHumanoid()
    local c = LP.Character
    return c and c:FindFirstChildOfClass("Humanoid")
end

local function GetRoot()
    local c = LP.Character
    return c and c:FindFirstChild("HumanoidRootPart")
end

local function GetAnimator()
    local h = GetHumanoid()
    if not h then return nil end
    return h:FindFirstChildOfClass("Animator") or h:WaitForChild("Animator", 3)
end

local State = {
    Target = nil,
    Freeze = false,
    Speed = false, SpeedValue = 50,
    Jump = false, JumpValue = 100,
    Noclip = false,
    InfJump = false,
    Fly = false, FlySpeed = 60,
    Spectate = false,
    Listen = false, ListenDepth = 12,
    CopyAnim = false,
    AntiAFK = false,
    Gravity = false, GravityValue = 196.2,
    FOV = false, FOVValue = 70,
    Spin = false, SpinSpeed = 10,
    Bhop = false,
    ClickTP = false,
    AntiVoid = false,
    Follow = false,
    Orbit = false, OrbitRadius = 8, OrbitSpeed = 2,
    Stick = false,
    CFrameSpeed = false, CFrameSpeedValue = 2,
    CamUnlock = false,
    CamNoOcclusion = false,
    CamMaxZoom = 128,
}

local OriginalGravity = Workspace.Gravity
local OrigCam = {
    Max = LP.CameraMaxZoomDistance,
    Min = LP.CameraMinZoomDistance,
    Occlusion = LP.DevCameraOcclusionMode,
}

local Thumbs = {}
local function GetThumb(userId)
    if Thumbs[userId] then return Thumbs[userId] end
    local ok, img = pcall(function()
        return (Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100))
    end)
    if ok and img then
        Thumbs[userId] = img
        return img
    end
    return ""
end

local function FindPlayer(text)
    text = string.lower(text or "")
    if text == "" then return nil end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then
            if string.sub(string.lower(p.Name), 1, #text) == text or string.sub(string.lower(p.DisplayName), 1, #text) == text then
                return p
            end
        end
    end
    return nil
end

local function CopyText(text)
    local ok = pcall(function()
        if setclipboard then setclipboard(text) elseif toclipboard then toclipboard(text) else error("no clipboard") end
    end)
    return ok
end

do
    local VALID_KEYS = { ["arven"] = true }
    local KEY_FILE = "Hexion/key.txt"
    local TS = game:GetService("TweenService")
    local function Norm(s) return (string.lower((tostring(s or ""):gsub("%s+", "")))) end
    local function Saved()
        local ok, r = pcall(function() return isfile and isfile(KEY_FILE) and readfile(KEY_FILE) end)
        if ok and type(r) == "string" then return r end
        return nil
    end
    local function Save(k)
        pcall(function()
            if makefolder and isfolder and not isfolder("Hexion") then makefolder("Hexion") end
            if writefile then writefile(KEY_FILE, k) end
        end)
    end

    local s = Saved()
    if not (s and VALID_KEYS[Norm(s)]) then
        local P = Theme.Pal
        local function mk(class, props, parent)
            local i = Instance.new(class)
            for k, v in pairs(props) do i[k] = v end
            i.Parent = parent
            return i
        end
        local function rnd(i, r) return mk("UICorner", { CornerRadius = UDim.new(0, r) }, i) end
        local function grad(i, rot) return mk("UIGradient", { Color = ColorSequence.new(P.ACCENT, P.ACCENT2), Rotation = rot or 0 }, i) end

        local gui = mk("ScreenGui", { Name = "HexionKey", ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 1000, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, GuiParent())
        local dim = mk("Frame", { Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0 }, gui)
        TS:Create(dim, TweenInfo.new(0.4), { BackgroundTransparency = 0.4 }):Play()

        local base = UDim2.new(0.5, 0, 0.5, 0)
        local card = mk("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 30), Size = UDim2.new(0, 400, 0, 310), BackgroundColor3 = P.PANEL, BorderSizePixel = 0 }, dim)
        rnd(card, 18)
        mk("UIStroke", { Color = P.STROKE, Thickness = 1.3, Transparency = 0.1 }, card)
        TS:Create(card, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = base }):Play()

        local bar = mk("Frame", { Position = UDim2.new(0, 18, 0, 0), Size = UDim2.new(1, -36, 0, 3), BackgroundColor3 = P.ACCENT, BorderSizePixel = 0 }, card)
        grad(bar)

        local logo = mk("Frame", { Position = UDim2.new(0.5, -26, 0, 26), Size = UDim2.new(0, 52, 0, 52), BackgroundColor3 = P.ACCENT, BorderSizePixel = 0 }, card)
        rnd(logo, 15)
        grad(logo, 45)
        mk("TextLabel", { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = "H", Font = Enum.Font.GothamBold, TextSize = 28, TextColor3 = P.DARK }, logo)

        mk("TextLabel", { Position = UDim2.new(0, 0, 0, 88), Size = UDim2.new(1, 0, 0, 28), BackgroundTransparency = 1, Text = "Hexion", Font = Enum.Font.GothamBold, TextSize = 24, TextColor3 = P.TEXT }, card)
        mk("TextLabel", { Position = UDim2.new(0, 0, 0, 118), Size = UDim2.new(1, 0, 0, 18), BackgroundTransparency = 1, Text = "Devam etmek için anahtarını gir", Font = Enum.Font.Gotham, TextSize = 13, TextColor3 = P.DIM }, card)

        local boxWrap = mk("Frame", { Position = UDim2.new(0, 36, 0, 154), Size = UDim2.new(1, -72, 0, 44), BackgroundColor3 = P.CARD, BorderSizePixel = 0 }, card)
        rnd(boxWrap, 13)
        local boxStroke = mk("UIStroke", { Color = P.STROKE, Thickness = 1, Transparency = 0.2 }, boxWrap)
        local box = mk("TextBox", { Position = UDim2.new(0, 14, 0, 0), Size = UDim2.new(1, -28, 1, 0), BackgroundTransparency = 1, Text = "", PlaceholderText = "Anahtar", PlaceholderColor3 = P.FAINT, ClearTextOnFocus = false, Font = Enum.Font.GothamMedium, TextSize = 14, TextColor3 = P.TEXT, TextXAlignment = Enum.TextXAlignment.Left }, boxWrap)
        box.Focused:Connect(function() TS:Create(boxStroke, TweenInfo.new(0.15), { Color = P.ACCENT, Transparency = 0 }):Play() end)
        box.FocusLost:Connect(function() TS:Create(boxStroke, TweenInfo.new(0.15), { Color = P.STROKE, Transparency = 0.2 }):Play() end)

        local btn = mk("TextButton", { Position = UDim2.new(0, 36, 0, 210), Size = UDim2.new(1, -72, 0, 42), BackgroundColor3 = P.ACCENT, BorderSizePixel = 0, AutoButtonColor = false, Text = "Doğrula", Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = P.DARK }, card)
        rnd(btn, 13)
        grad(btn)
        local msgLabel = mk("TextLabel", { Position = UDim2.new(0, 36, 0, 258), Size = UDim2.new(1, -72, 0, 18), BackgroundTransparency = 1, Text = "", Font = Enum.Font.GothamMedium, TextSize = 12, TextColor3 = P.DIM }, card)
        mk("TextLabel", { Position = UDim2.new(0, 0, 1, -24), Size = UDim2.new(1, 0, 0, 16), BackgroundTransparency = 1, Text = "Yapımcı: " .. CREATOR, Font = Enum.Font.Gotham, TextSize = 11, TextColor3 = P.FAINT }, card)

        local cancelled, passed = false, false
        local closeBtn = mk("TextButton", { Position = UDim2.new(1, -40, 0, 14), Size = UDim2.new(0, 26, 0, 26), BackgroundTransparency = 1, Text = "X", Font = Enum.Font.GothamBold, TextSize = 13, TextColor3 = P.FAINT, AutoButtonColor = false }, card)
        closeBtn.MouseButton1Click:Connect(function() cancelled = true end)
        btn.MouseEnter:Connect(function() TS:Create(btn, TweenInfo.new(0.12), { BackgroundColor3 = P.ACCENT:Lerp(Color3.new(1, 1, 1), 0.15) }):Play() end)
        btn.MouseLeave:Connect(function() TS:Create(btn, TweenInfo.new(0.12), { BackgroundColor3 = P.ACCENT }):Play() end)

        local function Msg(t, c) msgLabel.Text = t msgLabel.TextColor3 = c end
        local function Shake()
            task.spawn(function()
                for i = 1, 6 do
                    card.Position = base + UDim2.new(0, (i % 2 == 0) and 9 or -9, 0, 0)
                    task.wait(0.04)
                end
                card.Position = base
            end)
        end

        local fails, lockUntil = 0, 0
        local function Try()
            if passed or cancelled then return end
            if os.clock() < lockUntil then
                Msg("Çok fazla deneme. " .. math.ceil(lockUntil - os.clock()) .. " sn bekle.", P.WARN)
                return
            end
            local k = Norm(box.Text)
            if k == "" then Msg("Anahtarı gir.", P.WARN) return end
            if VALID_KEYS[k] then
                Msg("Anahtar doğrulandı. Hoş geldin!", P.GOOD)
                Save(k)
                passed = true
            else
                fails = fails + 1
                Shake()
                if fails >= 5 then
                    fails = 0
                    lockUntil = os.clock() + 10
                    Msg("Çok fazla yanlış deneme. 10 sn bekle.", P.BAD)
                else
                    Msg("Geçersiz anahtar. (" .. fails .. "/5)", P.BAD)
                end
            end
        end
        btn.MouseButton1Click:Connect(Try)
        box.FocusLost:Connect(function(enter) if enter then Try() end end)

        while not passed and not cancelled do task.wait(0.1) end
        if cancelled then
            gui:Destroy()
            error("Hexion: anahtar girilmedi, script durduruldu.", 0)
        end
        task.wait(0.6)
        TS:Create(dim, TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()
        TS:Create(card, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), { Position = UDim2.new(0.5, 0, 0.5, 30) }):Play()
        task.wait(0.35)
        gui:Destroy()
    end
end

local GameName = game.Name
task.spawn(function()
    local ok, info = pcall(function() return MarketplaceService:GetProductInfo(game.PlaceId) end)
    if ok and info and info.Name then GameName = info.Name end
end)

local Window = Airflow:CreateWindow({
    Name = "Hexion",
    LoadingSubtitle = "v10 · Yapımcı: " .. CREATOR .. " · Yükleniyor",
    Theme = "Default",
    ToggleUIKeybind = "RightControl",
    ConfigurationSaving = { Enabled = true, FolderName = "Hexion", FileName = "default" },
    Home = {
        Name = "Ana Sayfa",
        Stats = { "FPS", "Ping", "Executor", "Game", "Region", "Time" },
        Pages = {
            {
                Name = "Değişiklikler",
                Icon = "scroll-text",
                Entries = {
                    { Title = "v10 · Yapımcı: " .. CREATOR, Tag = "Güncel", Changes = {
                        "ESP kartları baştan tasarlandı: Kart, Cam, Rozet, Kompakt ve Minimal stilleri",
                        "Kart içinde can çubuğu, mesafe etiketi, can rengine göre avatar halkası ve renkli üst şerit",
                        "ESP: hedef rozeti ve hedef rengi, kenar can çubuğu anahtarı, tracer başlangıç noktası, ek şeffaflık, uzaktakileri küçültme",
                        "ESP sekmesi kategorilere ayrıldı: Genel, Kart tasarımı, Kart içeriği, Kutu, Vücut ve çizgiler, Filtreler ve renkler",
                        "Sekmeler kategoriye göre sıralandı: Karakter, Görsel, Oyun, Araçlar",
                        "Emote ve Animasyonlar sekmesi çok yakında olarak işaretlendi",
                        "Yeni: en yakın oyuncuyu seç, giriş/çıkış bildirimi, sunucu bilgisi, HUD'da ping",
                    } },
                    { Title = "v9 · Yapımcı: " .. CREATOR, Tag = "Önceki", Changes = {
                        "Key sistemi eklendi (anahtar bir kez kaydedilir)",
                        "Oyuncu panelindeki görünmeyen simgeler düzeltildi: çizilmiş vektör ikonlar ve yazı etiketleri",
                        "ESP kutusu yenilendi: degrade dolgu, yumuşak parlama, yuvarlak köşeli tam kutu",
                        "Yeni sekme: Troll (hedefe otur, sırtına bin, hortum, helikopter, ölü taklidi, emote spam)",
                        "Yeni sekme: Komşular (etkileşim ESP, anında etkileşim, NPC ESP + yakınlık uyarısı, eşya ESP, el feneri)",
                    } },
                    { Title = "v8 · Yapımcı: " .. CREATOR, Tag = "Önceki", Changes = {
                        "Yeni tema: Toz Pembe & Bebek Mavisi (Ayarlar > Panel teması: Toz Pembe, Bebek Mavisi, Orijinal)",
                        "Oyuncu listesi baştan tasarlandı: ışımalı cam görünüm, kayan filtre, avatar halkaları, durum noktası, detay kartı",
                        "Liste ve kitaplık, menünün renk ve yazı tipiyle eşitlenir",
                        "Emote ve animasyon kitaplığı: Roblox kataloğundaki tüm emote'lar ve paketler, arama, favori",
                        "Yeni ESP: köşeli/tam kutu, yan can çubuğu, avatarlı kart, iskelet, tracer, oyuncu işaretleme",
                        "Sekmeler yeniden düzenlendi: Oyuncular, Hareket, Animasyonlar, ESP, Dünya, Çeşitli, Ayarlar",
                    } },
                    { Title = "v7 · Yapımcı: " .. CREATOR, Tag = "Önceki", Changes = {
                        "Tamamen Türkçe arayüz",
                        "Sürüklenebilir oyuncu listesi: tüm oyuncular, oyun adı, TP / İzle / Dinle butonları",
                        "Kamera zoom sınırını kaldırma ve kameranın duvarlardan geçmesi",
                        "ESP: profil resmi, isim, mesafe, can barı, takım kontrolü, takım rengi, tracer, highlight",
                        "Hız, CFrame hız, zıplama, uçma, noclip, sonsuz zıplama, bhop, spin, tıkla ışınlan",
                        "Yerçekimi, FOV, anti-void, kayıt noktası, oturma ve sıfırlama",
                        "16 animasyon paketi ve 12 emote",
                        "Dünya sekmesi: fullbright, sis kaldırma, gölge kapatma, saat ayarı",
                        "Çeşitli sekmesi: yeniden katıl, sunucu değiştir, ID kopyala, FPS sınırı",
                        "Ekran üstü HUD: oyun adı, oyuncu sayısı, FPS ve yapımcı",
                    } },
                    { Title = "v5", Tag = "Önceki", Changes = {
                        "Emote ve animasyon paketleri",
                        "Animasyon kopyalama ve dondurma",
                        "Profil resimli temel ESP",
                    } },
                },
            },
            {
                Name = "Bilgi",
                Icon = "info",
                Content = "Hexion v10 — Yapımcı: " .. CREATOR .. ". Kategoriler: Karakter (Oyuncular, Hareket), Görsel (ESP, Dünya), Oyun (Komşular, Troll), Araçlar (Çeşitli), Ayarlar. Emote ve animasyonlar çok yakında. Menüyü gizlemek/göstermek için RightControl tuşunu kullan.",
            },
        },
    },
})

local PlayersTab = Window:CreateTab({ Name = "Oyuncular", Desc = "Karakter · Liste, ışınlan, izle, takip", Icon = "users" })
local Move = Window:CreateTab({ Name = "Hareket", Desc = "Karakter · Hız, uçma, noclip, ışınlanma", Icon = "footprints" })
local Visuals = Window:CreateTab({ Name = "ESP", Desc = "Görsel · Kart, kutu, can, iskelet, tracer", Icon = "eye" })
local World = Window:CreateTab({ Name = "Dünya", Desc = "Görsel · Işık, harita, kamera, HUD", Icon = "sun" })
local Nb = Window:CreateTab({ Name = "Komşular", Desc = "Oyun · Etkileşim, eşya, NPC, fener", Icon = "flag" })
local Troll = Window:CreateTab({ Name = "Troll", Desc = "Oyun · Hedef bazlı eğlence modları", Icon = "skull" })
local Misc = Window:CreateTab({ Name = "Çeşitli", Desc = "Araçlar · Sunucu, performans, eşyalar", Icon = "wrench" })
local Anim = Window:CreateTab({ Name = "Animasyonlar", Desc = "Çok yakında · Emote ve animasyon", Icon = "lock" })
local Settings = Window:CreateTab({ Name = "Ayarlar", Icon = "settings" })

local AnimOld = setmetatable({}, { __index = function() return function() end end })

local Emotes = {
    ["El Salla"] = 507770239,
    ["İşaret Et"] = 507770453,
    ["Dans 1"] = 507771019,
    ["Dans 2"] = 507776043,
    ["Dans 3"] = 507777268,
    ["Gülme"] = 507770818,
    ["Tezahürat"] = 507770677,
    ["Selam"] = 3360689775,
    ["Eğilme"] = 3360692915,
    ["Stadyum"] = 3360686498,
    ["Omuz Silkme"] = 3576968026,
    ["Merhaba"] = 3344650532,
}
local EmoteNames = { "El Salla", "İşaret Et", "Dans 1", "Dans 2", "Dans 3", "Gülme", "Tezahürat", "Selam", "Eğilme", "Stadyum", "Omuz Silkme", "Merhaba" }

local CurrentTrack
local AnimSpeed = 1
local EmoteLoop = true
local SelectedEmote = "El Salla"

local function StopCustom()
    if CurrentTrack then
        pcall(function() CurrentTrack:Stop(0.2) end)
        CurrentTrack = nil
    end
end

local function PlayAnimation(id)
    local animator = GetAnimator()
    if not animator then
        Notify("Animasyon", "Karakter bulunamadı.", "Error")
        return
    end
    StopCustom()
    local a = Instance.new("Animation")
    a.AnimationId = "rbxassetid://" .. tostring(id)
    local ok, track = pcall(function() return animator:LoadAnimation(a) end)
    if not ok or not track then
        Notify("Animasyon", "Bu animasyon yüklenemedi.", "Error")
        return
    end
    track.Priority = Enum.AnimationPriority.Action4
    track.Looped = EmoteLoop
    track:Play()
    track:AdjustSpeed(AnimSpeed)
    CurrentTrack = track
end

local LibraryAPI = {}

AnimOld:CreateSection("Kitaplık (tüm emote ve animasyonlar)")

AnimOld:CreateButton({
    Name = "Emote ve animasyon kitaplığını aç",
    Desc = "Roblox kataloğundaki tüm emote'lar ve animasyon paketleri: arama, favori, önizleme",
    Style = "Primary",
    Icon = "drama",
    Callback = function()
        if LibraryAPI.Toggle then LibraryAPI.Toggle() end
    end,
})

AnimOld:CreateKeybind({
    Name = "Kitaplık tuşu",
    CurrentKeybind = "O",
    Flag = "LibraryKey",
    Callback = function()
        if LibraryAPI.Toggle then LibraryAPI.Toggle() end
    end,
})

AnimOld:CreateSection("Emote'lar")

AnimOld:CreateDropdown({
    Name = "Emote",
    Options = EmoteNames,
    CurrentOption = "El Salla",
    Flag = "Emote",
    Callback = function(Option)
        if type(Option) == "table" then Option = Option[1] end
        SelectedEmote = Option
    end,
})

AnimOld:CreateButton({
    Name = "Emote'u oynat",
    Style = "Primary",
    Icon = "play",
    Callback = function()
        local id = Emotes[SelectedEmote]
        if id then PlayAnimation(id) end
    end,
})

AnimOld:CreateToggle({
    Name = "Döngü",
    Desc = "Durdurana kadar animasyonu tekrarla",
    CurrentValue = true,
    Flag = "EmoteLoop",
    Callback = function(Value)
        EmoteLoop = Value
        if CurrentTrack then CurrentTrack.Looped = Value end
    end,
})

AnimOld:CreateSlider({
    Name = "Animasyon hızı",
    Range = { 0, 5 },
    Increment = 0.1,
    Suffix = "x",
    CurrentValue = 1,
    Flag = "AnimSpeed",
    Callback = function(Value)
        AnimSpeed = Value
        if CurrentTrack then pcall(function() CurrentTrack:AdjustSpeed(Value) end) end
    end,
})

AnimOld:CreateInput({
    Name = "Özel animasyon ID",
    PlaceholderText = "örn. 507771019",
    MaxLength = 20,
    Flag = "CustomAnimID",
    Callback = function(Text, EnterPressed)
        local id = tonumber(Text)
        if id and EnterPressed then
            PlayAnimation(id)
        elseif EnterPressed then
            Notify("Animasyon", "Sayısal bir ID gir.", "Warning")
        end
    end,
})

AnimOld:CreateButton({
    Name = "Animasyonu durdur",
    Style = "Danger",
    Icon = "square",
    Callback = StopCustom,
})

AnimOld:CreateSection("Animasyon paketleri")

local Packs = {
    ["Ninja"] = { idle = 656117400, walk = 656121766, run = 656118852, jump = 656117878, fall = 656115606, climb = 656114359 },
    ["Zombi"] = { idle = 616158929, walk = 616168032, run = 616163682, jump = 616161997, fall = 616157476, climb = 616156119 },
    ["Robot"] = { idle = 616088211, walk = 616095330, run = 616091570, jump = 616090535, fall = 616087089, climb = 616086039 },
    ["Levitasyon"] = { idle = 616006778, walk = 616013216, run = 616010382, jump = 616008936, fall = 616005863, climb = 616003713 },
    ["Vampir"] = { idle = 1083445855, walk = 1083473930, run = 1083462077, jump = 1083455352, fall = 1083443587, climb = 1083439238 },
    ["Kurt Adam"] = { idle = 1083195517, walk = 1083178339, run = 1083216690, jump = 1083218792, fall = 1083189019, climb = 1083182000 },
    ["Çizgi Film"] = { idle = 742637544, walk = 742640026, run = 742638842, jump = 742637942, fall = 742637151, climb = 742636889 },
    ["Büyücü"] = { idle = 707742142, walk = 707897309, run = 707861613, jump = 707853694, fall = 707829716, climb = 707826056 },
    ["Oyuncak"] = { idle = 782841498, walk = 782843345, run = 782842708, jump = 782847020, fall = 782846423, climb = 782843869 },
    ["Şövalye"] = { idle = 657595757, walk = 657552124, run = 657564596, jump = 658409194, fall = 657600338, climb = 658360781 },
    ["Astronot"] = { idle = 891621366, walk = 891667138, run = 891636393, jump = 891627522, fall = 891617961, climb = 891609353 },
    ["Yaşlı"] = { idle = 845397899, walk = 845403856, run = 845386501, jump = 845398858, fall = 845396048, climb = 845392038 },
    ["Kabarcıklı"] = { idle = 910004836, walk = 910034870, run = 910025107, jump = 910016857, fall = 910001910, climb = 909997997 },
    ["Şık"] = { idle = 616136790, walk = 616146177, run = 616140816, jump = 616139451, fall = 616134815, climb = 616133594 },
    ["Süper Kahraman"] = { idle = 616111295, walk = 616122287, run = 616117076, jump = 616115533, fall = 616108001, climb = 616104706 },
    ["Korsan"] = { idle = 750781874, walk = 750785693, run = 750783738, jump = 750782230, fall = 750780242, climb = 750779899 },
}
local PackNames = { "Ninja", "Zombi", "Robot", "Levitasyon", "Vampir", "Kurt Adam", "Çizgi Film", "Büyücü", "Oyuncak", "Şövalye", "Astronot", "Yaşlı", "Kabarcıklı", "Şık", "Süper Kahraman", "Korsan" }
local SelectedPack = "Ninja"
local OriginalAnims = {}

local PackSlots = {
    { "idle", "Animation1", "idle" },
    { "idle", "Animation2", "idle" },
    { "walk", "WalkAnim", "walk" },
    { "run", "RunAnim", "run" },
    { "jump", "JumpAnim", "jump" },
    { "fall", "FallAnim", "fall" },
    { "climb", "ClimbAnim", "climb" },
    { "swim", "Swim", "swim" },
}

local function ReloadAnimate(animate)
    local animator = GetAnimator()
    animate.Disabled = true
    if animator then
        for _, t in ipairs(animator:GetPlayingAnimationTracks()) do
            t:Stop(0)
        end
    end
    task.wait()
    animate.Disabled = false
end

local function ApplyPackTable(pack, label)
    local ch = LP.Character
    local animate = ch and ch:FindFirstChild("Animate")
    if not animate then
        Notify("Paketler", "Animate scripti bulunamadı (varsayılan R15/R6 gerekir).", "Error")
        return false
    end
    if not pack then return false end
    for _, slot in ipairs(PackSlots) do
        local pid = pack[slot[3]]
        if pid then
            local folder = animate:FindFirstChild(slot[1])
            local anim = folder and folder:FindFirstChild(slot[2])
            if anim then
                local key = slot[1] .. slot[2]
                if not OriginalAnims[key] then OriginalAnims[key] = anim.AnimationId end
                anim.AnimationId = "rbxassetid://" .. string.format("%.0f", pid)
            end
        end
    end
    ReloadAnimate(animate)
    Notify("Paketler", label .. " uygulandı.", "Success")
    return true
end

local function ApplyPack(name)
    ApplyPackTable(Packs[name], name)
end

local function ResetPack()
    local ch = LP.Character
    local animate = ch and ch:FindFirstChild("Animate")
    if not animate then return end
    for _, slot in ipairs(PackSlots) do
        local folder = animate:FindFirstChild(slot[1])
        local anim = folder and folder:FindFirstChild(slot[2])
        local orig = OriginalAnims[slot[1] .. slot[2]]
        if anim and orig then anim.AnimationId = orig end
    end
    ReloadAnimate(animate)
    Notify("Paketler", "Varsayılan animasyonlar geri yüklendi.", "Info")
end

AnimOld:CreateDropdown({
    Name = "Paket",
    Options = PackNames,
    CurrentOption = "Ninja",
    Flag = "AnimPack",
    Callback = function(Option)
        if type(Option) == "table" then Option = Option[1] end
        SelectedPack = Option
    end,
})

AnimOld:CreateButton({
    Name = "Paketi uygula",
    Style = "Primary",
    Icon = "check",
    Callback = function() ApplyPack(SelectedPack) end,
})

AnimOld:CreateButton({
    Name = "Varsayılana sıfırla",
    Icon = "rotate-ccw",
    Callback = ResetPack,
})

AnimOld:CreateSection("Özel paket slotu")

local SlotMap = {
    ["Duruş"] = "idle", ["Yürüme"] = "walk", ["Koşma"] = "run",
    ["Zıplama"] = "jump", ["Düşme"] = "fall", ["Tırmanma"] = "climb",
}
local CustomSlot = "walk"
AnimOld:CreateDropdown({
    Name = "Slot",
    Options = { "Duruş", "Yürüme", "Koşma", "Zıplama", "Düşme", "Tırmanma" },
    CurrentOption = "Yürüme",
    Flag = "CustomSlot",
    Callback = function(Option)
        if type(Option) == "table" then Option = Option[1] end
        CustomSlot = SlotMap[Option] or "walk"
    end,
})

AnimOld:CreateInput({
    Name = "Slot animasyon ID",
    Desc = "Seçili slotu kendi ID'nle değiştir",
    PlaceholderText = "animasyon id",
    MaxLength = 20,
    Callback = function(Text, EnterPressed)
        if not EnterPressed then return end
        local id = tonumber(Text)
        local ch = LP.Character
        local animate = ch and ch:FindFirstChild("Animate")
        if not id or not animate then
            Notify("Paketler", "Geçersiz ID veya Animate scripti yok.", "Warning")
            return
        end
        for _, slot in ipairs(PackSlots) do
            if slot[1] == CustomSlot then
                local folder = animate:FindFirstChild(slot[1])
                local anim = folder and folder:FindFirstChild(slot[2])
                if anim then
                    local key = slot[1] .. slot[2]
                    if not OriginalAnims[key] then OriginalAnims[key] = anim.AnimationId end
                    anim.AnimationId = "rbxassetid://" .. tostring(id)
                end
            end
        end
        ReloadAnimate(animate)
        Notify("Paketler", "Slot güncellendi.", "Success")
    end,
})

AnimOld:CreateSection("Animasyon kopyalama")

local CopyTracks = {}

local function StopCopy()
    for id, t in pairs(CopyTracks) do
        pcall(function() t:Stop(0.1) end)
        CopyTracks[id] = nil
    end
end

local function CopyStep()
    local target = State.Target
    local tch = target and target.Character
    local thum = tch and tch:FindFirstChildOfClass("Humanoid")
    local tanim = thum and thum:FindFirstChildOfClass("Animator")
    local manim = GetAnimator()
    if not tanim or not manim then return end

    local seen = {}
    for _, tr in ipairs(tanim:GetPlayingAnimationTracks()) do
        local id = tr.Animation and tr.Animation.AnimationId
        if id and id ~= "" then
            seen[id] = true
            local mine = CopyTracks[id]
            if not mine then
                local a = Instance.new("Animation")
                a.AnimationId = id
                local ok, loaded = pcall(function() return manim:LoadAnimation(a) end)
                if ok and loaded then
                    loaded.Priority = Enum.AnimationPriority.Action4
                    loaded.Looped = tr.Looped
                    loaded:Play(0.1, math.max(tr.WeightCurrent, 0.01), tr.Speed)
                    CopyTracks[id] = loaded
                    mine = loaded
                end
            end
            if mine then
                pcall(function()
                    mine:AdjustSpeed(tr.Speed)
                    if math.abs(mine.TimePosition - tr.TimePosition) > 0.2 then
                        mine.TimePosition = tr.TimePosition
                    end
                end)
            end
        end
    end
    for id, t in pairs(CopyTracks) do
        if not seen[id] then
            pcall(function() t:Stop(0.1) end)
            CopyTracks[id] = nil
        end
    end
end

AnimOld:CreateToggle({
    Name = "Seçili oyuncunun animasyonunu kopyala",
    Desc = "Önce Oyuncular sekmesinden veya listeden bir oyuncu seç",
    CurrentValue = false,
    Flag = "CopyAnim",
    Callback = function(Value)
        State.CopyAnim = Value
        if Value and not State.Target then
            Notify("Animasyon kopyalama", "Önce bir oyuncu seç.", "Warning")
        end
        if not Value then StopCopy() end
    end,
})

AnimOld:CreateButton({
    Name = "Seçili oyuncunun animasyon ID'lerini kopyala",
    Icon = "copy",
    Callback = function()
        local t = State.Target
        local hum = t and t.Character and t.Character:FindFirstChildOfClass("Humanoid")
        local animator = hum and hum:FindFirstChildOfClass("Animator")
        if not animator then
            Notify("Animasyon", "Önce geçerli bir oyuncu seç.", "Warning")
            return
        end
        local ids = {}
        for _, tr in ipairs(animator:GetPlayingAnimationTracks()) do
            local id = tr.Animation and tr.Animation.AnimationId
            if id and id ~= "" then table.insert(ids, (string.gsub(id, "%D", ""))) end
        end
        if #ids == 0 then
            Notify("Animasyon", "Oynayan animasyon yok.", "Info")
        elseif CopyText(table.concat(ids, ", ")) then
            Notify("Animasyon", #ids .. " ID kopyalandı.", "Success")
        else
            Notify("Animasyon", "Panoya kopyalama desteklenmiyor.", "Error")
        end
    end,
})

do
    local function Soon(what)
        Notify("Çok yakında", what .. " üzerinde çalışıyoruz, bir sonraki sürümde burada olacak.", "Info")
    end

    Anim:CreateSection("Çok yakında")
    Anim:CreateButton({
        Name = "Emote ve animasyon bölümü hazırlanıyor",
        Desc = "Daha iyi bir kitaplık, önizleme ve favoriler ile geri dönecek",
        Style = "Primary",
        Icon = "lock",
        Callback = function() Soon("Emote ve animasyon bölümü") end,
    })

    Anim:CreateSection("Emote'lar · çok yakında")
    Anim:CreateButton({
        Name = "Emote kitaplığı",
        Desc = "Tüm emote'lar, arama ve favoriler · Çok yakında",
        Icon = "lock",
        Callback = function() Soon("Emote kitaplığı") end,
    })
    Anim:CreateButton({
        Name = "Emote oynatıcı",
        Desc = "Döngü, hız ayarı ve özel ID desteği · Çok yakında",
        Icon = "lock",
        Callback = function() Soon("Emote oynatıcı") end,
    })

    Anim:CreateSection("Animasyon paketleri · çok yakında")
    Anim:CreateButton({
        Name = "Paket seçici",
        Desc = "Ninja, Zombi, Robot, Vampir ve daha fazlası · Çok yakında",
        Icon = "lock",
        Callback = function() Soon("Animasyon paketleri") end,
    })
    Anim:CreateButton({
        Name = "Özel paket slotları",
        Desc = "Yürüme, koşma, zıplama animasyonunu kendi ID'nle değiştir · Çok yakında",
        Icon = "lock",
        Callback = function() Soon("Özel paket slotları") end,
    })

    Anim:CreateSection("Animasyon kopyalama · çok yakında")
    Anim:CreateButton({
        Name = "Hedefin animasyonunu kopyala",
        Desc = "Seçtiğin oyuncunun animasyonlarını canlı kopyalar · Çok yakında",
        Icon = "lock",
        Callback = function() Soon("Animasyon kopyalama") end,
    })
end

Move:CreateSection("Hız ve zıplama")

Move:CreateToggle({
    Name = "Hız",
    CurrentValue = false,
    Flag = "SpeedToggle",
    Callback = function(Value)
        State.Speed = Value
        if not Value then
            local h = GetHumanoid()
            if h then h.WalkSpeed = 16 end
        end
    end,
})

Move:CreateSlider({
    Name = "Yürüme hızı",
    Range = { 16, 300 },
    Increment = 1,
    CurrentValue = 50,
    Flag = "SpeedValue",
    Callback = function(Value) State.SpeedValue = Value end,
})

Move:CreateToggle({
    Name = "CFrame hızı",
    Desc = "CFrame ile hareket ettirir (WalkSpeed'den daha zor fark edilir)",
    CurrentValue = false,
    Flag = "CFrameSpeed",
    Callback = function(Value) State.CFrameSpeed = Value end,
})

Move:CreateSlider({
    Name = "CFrame hız değeri",
    Range = { 1, 10 },
    Increment = 0.1,
    CurrentValue = 2,
    Flag = "CFrameSpeedValue",
    Callback = function(Value) State.CFrameSpeedValue = Value end,
})

Move:CreateToggle({
    Name = "Zıplama gücü",
    CurrentValue = false,
    Flag = "JumpToggle",
    Callback = function(Value)
        State.Jump = Value
        if not Value then
            local h = GetHumanoid()
            if h then h.JumpPower = 50 end
        end
    end,
})

Move:CreateSlider({
    Name = "Zıplama değeri",
    Range = { 50, 300 },
    Increment = 1,
    CurrentValue = 100,
    Flag = "JumpValue",
    Callback = function(Value) State.JumpValue = Value end,
})

Move:CreateToggle({
    Name = "Sonsuz zıplama",
    CurrentValue = false,
    Flag = "InfJump",
    Callback = function(Value) State.InfJump = Value end,
})

Move:CreateToggle({
    Name = "Bunny hop",
    Desc = "Space'e basılı tutunca sürekli zıpla",
    CurrentValue = false,
    Flag = "Bhop",
    Callback = function(Value) State.Bhop = Value end,
})

Move:CreateSection("Çarpışma ve uçuş")

local NoclipParts = {}
local function RestoreNoclip()
    for part in pairs(NoclipParts) do
        if part and part.Parent then part.CanCollide = true end
    end
    NoclipParts = {}
end

Move:CreateToggle({
    Name = "Noclip",
    Desc = "Duvarların içinden geç",
    CurrentValue = false,
    Flag = "Noclip",
    Callback = function(Value)
        State.Noclip = Value
        if not Value then RestoreNoclip() end
    end,
})

Move:CreateKeybind({
    Name = "Noclip tuşu",
    CurrentKeybind = "N",
    Flag = "NoclipKey",
    Callback = function()
        State.Noclip = not State.Noclip
        if not State.Noclip then RestoreNoclip() end
        Notify("Noclip", State.Noclip and "Açıldı" or "Kapandı", State.Noclip and "Success" or "Info")
    end,
})

local FlyBV, FlyBG
local function StopFly()
    if FlyBV then FlyBV:Destroy() FlyBV = nil end
    if FlyBG then FlyBG:Destroy() FlyBG = nil end
    local h = GetHumanoid()
    if h then h.PlatformStand = false end
end

local function StartFly()
    local root, hum = GetRoot(), GetHumanoid()
    if not root or not hum then return end
    StopFly()
    FlyBV = Instance.new("BodyVelocity")
    FlyBV.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    FlyBV.Velocity = Vector3.zero
    FlyBV.Parent = root
    FlyBG = Instance.new("BodyGyro")
    FlyBG.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
    FlyBG.P = 9e4
    FlyBG.CFrame = root.CFrame
    FlyBG.Parent = root
    hum.PlatformStand = true
end

Move:CreateToggle({
    Name = "Uçma",
    Desc = "WASD hareket, Space yukarı, LeftControl aşağı",
    CurrentValue = false,
    Flag = "Fly",
    Callback = function(Value)
        State.Fly = Value
        if Value then StartFly() else StopFly() end
    end,
})

Move:CreateKeybind({
    Name = "Uçma tuşu",
    CurrentKeybind = "F",
    Flag = "FlyKey",
    Callback = function()
        State.Fly = not State.Fly
        if State.Fly then StartFly() else StopFly() end
        Notify("Uçma", State.Fly and "Açıldı" or "Kapandı", State.Fly and "Success" or "Info")
    end,
})

Move:CreateSlider({
    Name = "Uçma hızı",
    Range = { 10, 300 },
    Increment = 1,
    CurrentValue = 60,
    Flag = "FlySpeed",
    Callback = function(Value) State.FlySpeed = Value end,
})

Move:CreateSection("Fizik")

Move:CreateToggle({
    Name = "Özel yerçekimi",
    CurrentValue = false,
    Flag = "GravityToggle",
    Callback = function(Value)
        State.Gravity = Value
        if not Value then Workspace.Gravity = OriginalGravity end
    end,
})

Move:CreateSlider({
    Name = "Yerçekimi",
    Range = { 0, 400 },
    Increment = 1,
    CurrentValue = 196,
    Flag = "GravityValue",
    Callback = function(Value) State.GravityValue = Value end,
})

Move:CreateToggle({
    Name = "Dönme (Spin)",
    Desc = "Karakterini döndür",
    CurrentValue = false,
    Flag = "Spin",
    Callback = function(Value) State.Spin = Value end,
})

Move:CreateSlider({
    Name = "Dönme hızı",
    Range = { 1, 60 },
    Increment = 1,
    CurrentValue = 10,
    Flag = "SpinSpeed",
    Callback = function(Value) State.SpinSpeed = Value end,
})

Move:CreateSection("Işınlanma")

Move:CreateToggle({
    Name = "Tıkla ışınlan",
    Desc = "LeftControl basılıyken tıkladığın yere ışınlan",
    CurrentValue = false,
    Flag = "ClickTP",
    Callback = function(Value) State.ClickTP = Value end,
})

Move:CreateToggle({
    Name = "Anti void",
    Desc = "Boşluğa düşersen son güvenli konuma döner",
    CurrentValue = false,
    Flag = "AntiVoid",
    Callback = function(Value) State.AntiVoid = Value end,
})

local Waypoint
Move:CreateButton({
    Name = "Kayıt noktası koy",
    Icon = "flag",
    Callback = function()
        local root = GetRoot()
        if root then
            Waypoint = root.CFrame
            Notify("Kayıt noktası", "Konum kaydedildi.", "Success")
        end
    end,
})

Move:CreateButton({
    Name = "Kayıt noktasına ışınlan",
    Style = "Primary",
    Icon = "map-pin",
    Callback = function()
        local root = GetRoot()
        if root and Waypoint then
            root.CFrame = Waypoint
        else
            Notify("Kayıt noktası", "Kayıtlı konum yok.", "Warning")
        end
    end,
})

Move:CreateSection("Araçlar")

Move:CreateToggle({
    Name = "Anti AFK",
    CurrentValue = false,
    Flag = "AntiAFK",
    Callback = function(Value) State.AntiAFK = Value end,
})

Move:CreateSection("Karakter")

Move:CreateToggle({
    Name = "Dondur",
    Desc = "Karakterini olduğu yerde sabitler",
    CurrentValue = false,
    Flag = "Freeze",
    Callback = function(Value)
        State.Freeze = Value
        local root = GetRoot()
        if root then root.Anchored = Value end
    end,
})

Move:CreateButton({
    Name = "Otur",
    Icon = "armchair",
    Callback = function()
        local h = GetHumanoid()
        if h then h.Sit = true end
    end,
})

Move:CreateButton({
    Name = "Karakteri sıfırla",
    Style = "Danger",
    Icon = "skull",
    Callback = function()
        local h = GetHumanoid()
        if h then h.Health = 0 end
    end,
})

local PlayerMap = {}
local PlayerDropdown

local function BuildPlayerOptions()
    local opts, map = {}, {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then
            local label = p.DisplayName .. " (@" .. p.Name .. ")"
            table.insert(opts, label)
            map[label] = p
        end
    end
    if #opts == 0 then opts = { "(başka oyuncu yok)" } end
    return opts, map
end

local CardGui = Instance.new("ScreenGui")
CardGui.Name = "HexionCard"
CardGui.ResetOnSpawn = false
CardGui.Enabled = false
CardGui.Parent = GuiParent()

local Card = Instance.new("Frame")
Card.Size = UDim2.new(0, 230, 0, 76)
Card.Position = UDim2.new(1, -246, 0, 16)
Card.BackgroundColor3 = Theme.Pal.PANEL
Card.BorderSizePixel = 0
Card.Parent = CardGui
Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 14)
local CardStroke = Instance.new("UIStroke", Card)
CardStroke.Color = ACCENT
CardStroke.Transparency = 0.45
CardStroke.Thickness = 1.5

local CardImg = Instance.new("ImageLabel")
CardImg.Size = UDim2.new(0, 54, 0, 54)
CardImg.Position = UDim2.new(0, 11, 0.5, -27)
CardImg.BackgroundColor3 = Theme.Pal.CHIP
CardImg.BorderSizePixel = 0
CardImg.Parent = Card
Instance.new("UICorner", CardImg).CornerRadius = UDim.new(1, 0)
local CardImgStroke = Instance.new("UIStroke", CardImg)
CardImgStroke.Color = ACCENT
CardImgStroke.Thickness = 2

local CardTag = Instance.new("TextLabel")
CardTag.Size = UDim2.new(1, -84, 0, 12)
CardTag.Position = UDim2.new(0, 76, 0, 8)
CardTag.BackgroundTransparency = 1
CardTag.TextXAlignment = Enum.TextXAlignment.Left
CardTag.Font = Enum.Font.GothamBold
CardTag.TextSize = 10
CardTag.TextColor3 = ACCENT
CardTag.Text = "SEÇİLİ OYUNCU"
CardTag.Parent = Card

local CardName = Instance.new("TextLabel")
CardName.Size = UDim2.new(1, -84, 0, 22)
CardName.Position = UDim2.new(0, 76, 0, 22)
CardName.BackgroundTransparency = 1
CardName.TextXAlignment = Enum.TextXAlignment.Left
CardName.Font = Enum.Font.GothamBold
CardName.TextSize = 15
CardName.TextColor3 = Theme.Pal.TEXT
CardName.TextTruncate = Enum.TextTruncate.AtEnd
CardName.Text = ""
CardName.Parent = Card

local CardSub = Instance.new("TextLabel")
CardSub.Size = UDim2.new(1, -84, 0, 16)
CardSub.Position = UDim2.new(0, 76, 0, 46)
CardSub.BackgroundTransparency = 1
CardSub.TextXAlignment = Enum.TextXAlignment.Left
CardSub.Font = Enum.Font.Gotham
CardSub.TextSize = 12
CardSub.TextColor3 = Theme.Pal.DIM
CardSub.TextTruncate = Enum.TextTruncate.AtEnd
CardSub.Text = ""
CardSub.Parent = Card

Theme.Bind(Card, "BackgroundColor3", "PANEL")
Theme.Bind(CardStroke, "Color", "ACCENT")
Theme.Bind(CardImg, "BackgroundColor3", "CHIP")
Theme.Bind(CardImgStroke, "Color", "ACCENT")
Theme.Bind(CardTag, "TextColor3", "ACCENT")
Theme.Bind(CardName, "TextColor3", "TEXT")
Theme.Bind(CardSub, "TextColor3", "DIM")

local ShowCard = true
local function UpdateCard()
    local t = State.Target
    if t and ShowCard then
        CardName.Text = t.DisplayName
        CardSub.Text = "@" .. t.Name
        CardGui.Enabled = true
        task.spawn(function()
            local img = GetThumb(t.UserId)
            if State.Target == t then CardImg.Image = img end
        end)
    else
        CardGui.Enabled = false
    end
end

local function SetTarget(p)
    State.Target = p
    UpdateCard()
    if State.Spectate then
        local h = p and p.Character and p.Character:FindFirstChildOfClass("Humanoid")
        if h then Workspace.CurrentCamera.CameraSubject = h end
    end
end

local SpectateToggle, ListenToggle
local SetListen
local ListenConn, ListenSavedCF

local function SetSpectate(v)
    if State.Spectate == v then return end
    if v and State.Listen then SetListen(false) end
    State.Spectate = v
    local cam = Workspace.CurrentCamera
    if v then
        local t = State.Target
        local h = t and t.Character and t.Character:FindFirstChildOfClass("Humanoid")
        if h then
            cam.CameraSubject = h
        else
            Notify("İzle", "Önce geçerli bir oyuncu seç.", "Warning")
        end
    else
        local h = GetHumanoid()
        if h then cam.CameraSubject = h end
    end
    if SpectateToggle then pcall(function() SpectateToggle:Set(v) end) end
end

SetListen = function(v)
    if State.Listen == v then return end
    if v then
        local t = State.Target
        local tr = t and t.Character and t.Character:FindFirstChild("HumanoidRootPart")
        local myRoot = GetRoot()
        if not (tr and myRoot) then
            Notify("Dinle", "Önce geçerli bir oyuncu seç.", "Warning")
            if ListenToggle then pcall(function() ListenToggle:Set(false) end) end
            return
        end
        if State.Spectate then SetSpectate(false) end
        State.Listen = true
        ListenSavedCF = myRoot.CFrame
        if ListenConn then ListenConn:Disconnect() end
        ListenConn = RunService.Heartbeat:Connect(function()
            local tgt = State.Target
            if not tgt or not tgt.Parent then return end
            local th = tgt.Character and tgt.Character:FindFirstChildOfClass("Humanoid")
            local trt = tgt.Character and tgt.Character:FindFirstChild("HumanoidRootPart")
            if not (th and trt) then return end
            local cam = Workspace.CurrentCamera
            if cam and cam.CameraSubject ~= th then
                cam.CameraType = Enum.CameraType.Custom
                cam.CameraSubject = th
            end
            local r = GetRoot()
            if r then
                r.Anchored = true
                r.AssemblyLinearVelocity = Vector3.zero
                r.CFrame = CFrame.new(trt.Position - Vector3.new(0, State.ListenDepth, 0))
            end
        end)
        Notify("Dinle", t.DisplayName .. " dinleniyor (görünmez).", "Success")
    else
        State.Listen = false
        if ListenConn then ListenConn:Disconnect() ListenConn = nil end
        local cam = Workspace.CurrentCamera
        local h = GetHumanoid()
        if cam and h then
            cam.CameraSubject = h
            cam.CameraType = Enum.CameraType.Custom
        end
        local r = GetRoot()
        if r then
            if ListenSavedCF then r.CFrame = ListenSavedCF end
            r.Anchored = State.Freeze
            r.AssemblyLinearVelocity = Vector3.zero
        end
        ListenSavedCF = nil
    end
    if ListenToggle then pcall(function() ListenToggle:Set(v) end) end
end

local function TeleportToPlayer(p)
    local troot = p and p.Character and p.Character:FindFirstChild("HumanoidRootPart")
    local root = GetRoot()
    if troot and root then
        root.CFrame = troot.CFrame * CFrame.new(0, 0, 3)
        return true
    end
    return false
end

PlayersTab:CreateSection("Oyuncu seç")

local initOpts, initMap = BuildPlayerOptions()
PlayerMap = initMap

PlayerDropdown = PlayersTab:CreateDropdown({
    Name = "Oyuncular",
    Options = initOpts,
    CurrentOption = initOpts[1],
    Placeholder = "Bir oyuncu seç",
    Callback = function(Option)
        if type(Option) == "table" then Option = Option[1] end
        SetTarget(PlayerMap[Option])
    end,
})

local function RefreshPlayers()
    local opts, map = BuildPlayerOptions()
    PlayerMap = map
    if PlayerDropdown then
        for _, method in ipairs({ "Refresh", "SetOptions", "UpdateOptions" }) do
            if PlayerDropdown[method] then
                local ok = pcall(PlayerDropdown[method], PlayerDropdown, opts)
                if ok then break end
            end
        end
    end
end

PlayersTab:CreateButton({
    Name = "Oyuncu listesini yenile",
    Icon = "refresh-cw",
    Callback = function()
        RefreshPlayers()
        Notify("Oyuncular", "Liste yenilendi.", "Success")
    end,
})

PlayersTab:CreateInput({
    Name = "İsimle bul",
    Desc = "İsmin bir kısmını yaz ve Enter'a bas",
    PlaceholderText = "kullanıcı adı veya görünen ad",
    MaxLength = 32,
    Callback = function(Text, EnterPressed)
        if not EnterPressed then return end
        local p = FindPlayer(Text)
        if p then
            SetTarget(p)
            Notify("Oyuncular", p.DisplayName .. " seçildi.", "Success")
        else
            Notify("Oyuncular", "Oyuncu bulunamadı.", "Warning")
        end
    end,
})

PlayersTab:CreateButton({
    Name = "Rastgele oyuncu seç",
    Icon = "shuffle",
    Callback = function()
        local list = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP then table.insert(list, p) end
        end
        if #list == 0 then
            Notify("Oyuncular", "Başka oyuncu yok.", "Warning")
            return
        end
        local p = list[math.random(1, #list)]
        SetTarget(p)
        Notify("Oyuncular", p.DisplayName .. " seçildi.", "Success")
    end,
})

PlayersTab:CreateButton({
    Name = "En yakın oyuncuyu seç",
    Desc = "Sana en yakın oyuncuyu hedef yapar",
    Icon = "crosshair",
    Callback = function()
        local root = GetRoot()
        if not root then
            Notify("Oyuncular", "Karakter bulunamadı.", "Warning")
            return
        end
        local best, bestD
        for _, p in ipairs(Players:GetPlayers()) do
            local r = p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart")
            if r then
                local d = (r.Position - root.Position).Magnitude
                if not bestD or d < bestD then best, bestD = p, d end
            end
        end
        if best then
            SetTarget(best)
            Notify("Oyuncular", best.DisplayName .. " seçildi (" .. math.floor(bestD) .. " birim).", "Success")
        else
            Notify("Oyuncular", "Yakında oyuncu yok.", "Warning")
        end
    end,
})

PlayersTab:CreateToggle({
    Name = "Oyuncu kartını göster",
    Desc = "Seçili oyuncunun avatarı ve adı",
    CurrentValue = true,
    Flag = "ShowCard",
    Callback = function(Value)
        ShowCard = Value
        UpdateCard()
    end,
})

PlayersTab:CreateButton({
    Name = "Oyuncu bilgisi",
    Icon = "id-card",
    Callback = function()
        local t = State.Target
        if not t then
            Notify("Bilgi", "Önce bir oyuncu seç.", "Warning")
            return
        end
        local team = t.Team and t.Team.Name or "Yok"
        Notify(t.DisplayName, string.format("@%s · ID %d · Hesap yaşı %d gün · Takım: %s", t.Name, t.UserId, t.AccountAge, team), "Info")
    end,
})

PlayersTab:CreateButton({
    Name = "Kullanıcı adı / UserId kopyala",
    Icon = "copy",
    Callback = function()
        local t = State.Target
        if not t then
            Notify("Kopyala", "Önce bir oyuncu seç.", "Warning")
            return
        end
        if CopyText(t.Name .. " | " .. t.UserId) then
            Notify("Kopyala", "Kopyalandı.", "Success")
        else
            Notify("Kopyala", "Panoya kopyalama desteklenmiyor.", "Error")
        end
    end,
})

PlayersTab:CreateSection("İşlemler")

PlayersTab:CreateButton({
    Name = "Oyuncuya ışınlan",
    Style = "Primary",
    Icon = "map-pin",
    Callback = function()
        if not TeleportToPlayer(State.Target) then
            Notify("Işınlan", "Önce geçerli bir oyuncu seç.", "Warning")
        end
    end,
})

SpectateToggle = PlayersTab:CreateToggle({
    Name = "İzle",
    CurrentValue = false,
    Flag = "Spectate",
    Callback = function(Value) SetSpectate(Value) end,
})

ListenToggle = PlayersTab:CreateToggle({
    Name = "Dinle modu",
    Desc = "Kameran hedefe geçer, karakterin hedefin altına gizlenip onu takip eder. Kapatınca eski yerine dönersin",
    CurrentValue = false,
    Flag = "Listen",
    Callback = function(Value) SetListen(Value) end,
})

PlayersTab:CreateSlider({
    Name = "Dinleme derinliği",
    Desc = "Karakterin hedefin kaç stud altında gizlensin",
    Range = { 3, 40 },
    Increment = 1,
    CurrentValue = 12,
    Flag = "ListenDepth",
    Callback = function(Value) State.ListenDepth = Value end,
})

PlayersTab:CreateSection("Takip modları")

PlayersTab:CreateToggle({
    Name = "Takip et",
    Desc = "Seçili oyuncuya doğru yürü",
    CurrentValue = false,
    Flag = "Follow",
    Callback = function(Value) State.Follow = Value end,
})

PlayersTab:CreateToggle({
    Name = "Oyuncuya yapış",
    Desc = "Seçili oyuncunun hemen arkasında kal",
    CurrentValue = false,
    Flag = "Stick",
    Callback = function(Value) State.Stick = Value end,
})

PlayersTab:CreateToggle({
    Name = "Oyuncunun etrafında dön",
    Desc = "Seçili oyuncunun etrafında daire çiz",
    CurrentValue = false,
    Flag = "Orbit",
    Callback = function(Value) State.Orbit = Value end,
})

PlayersTab:CreateSlider({
    Name = "Dönüş yarıçapı",
    Range = { 3, 40 },
    Increment = 1,
    CurrentValue = 8,
    Flag = "OrbitRadius",
    Callback = function(Value) State.OrbitRadius = Value end,
})

PlayersTab:CreateSlider({
    Name = "Dönüş hızı",
    Range = { 1, 15 },
    Increment = 0.5,
    CurrentValue = 2,
    Flag = "OrbitSpeed",
    Callback = function(Value) State.OrbitSpeed = Value end,
})

local UI = { Guis = {}, Marked = {} }
local PL = { Rows = {}, Headers = {}, Filter = "", Sort = "Ad", Mode = "Hepsi" }
local RefreshList, UpdateListState
local LibGui
local ESP, BuildESP, ClearESP, RebuildESP, ApplyESPStyle

do
    local TweenService = game:GetService("TweenService")

    UI.C = {}
    for k, v in pairs(Theme.Pal) do UI.C[k] = v end
    UI.Binds = Theme.Binds
    local C = UI.C

    function UI.New(class, props, parent)
        local inst = Instance.new(class)
        if props then
            for k, v in pairs(props) do inst[k] = v end
        end
        if parent then inst.Parent = parent end
        return inst
    end

    function UI.Round(inst, r)
        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(0, r or 8)
        c.Parent = inst
        return c
    end

    function UI.Stroke(inst, color, thickness, transparency)
        local s = Instance.new("UIStroke")
        s.Color = color or C.STROKE
        s.Thickness = thickness or 1
        s.Transparency = transparency or 0
        s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        s.Parent = inst
        return s
    end

    function UI.Pad(inst, l, t, r, b)
        local p = Instance.new("UIPadding")
        p.PaddingLeft = UDim.new(0, l or 0)
        p.PaddingTop = UDim.new(0, t or 0)
        p.PaddingRight = UDim.new(0, r or 0)
        p.PaddingBottom = UDim.new(0, b or 0)
        p.Parent = inst
        return p
    end

    function UI.Tween(inst, t, props)
        local tw = TweenService:Create(inst, TweenInfo.new(t or 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
        tw:Play()
        return tw
    end

    function UI.Label(parent, props)
        local l = Instance.new("TextLabel")
        l.BackgroundTransparency = 1
        l.BorderSizePixel = 0
        l.Font = Enum.Font.Gotham
        l.TextSize = 12
        l.TextColor3 = C.TEXT
        l.TextXAlignment = Enum.TextXAlignment.Left
        l.TextTruncate = Enum.TextTruncate.AtEnd
        for k, v in pairs(props or {}) do l[k] = v end
        UI.StyleFont(l)
        l.Parent = parent
        return l
    end

    function UI.Button(parent, text, props)
        local b = Instance.new("TextButton")
        b.AutoButtonColor = false
        b.BackgroundColor3 = C.CHIP
        b.BorderSizePixel = 0
        b.Font = Enum.Font.GothamMedium
        b.TextSize = 12
        b.TextColor3 = C.TEXT
        b.Text = text
        for k, v in pairs(props or {}) do b[k] = v end
        UI.Round(b, 8)
        local active, hover = false, false
        local function paint()
            local bg = active and C.ACCENT or (hover and C.HOVER or C.CHIP)
            UI.Tween(b, 0.12, { BackgroundColor3 = bg, TextColor3 = active and C.DARK or C.TEXT })
        end
        b.MouseEnter:Connect(function() hover = true paint() end)
        b.MouseLeave:Connect(function() hover = false paint() end)
        UI.StyleFont(b)
        b.Parent = parent
        local api = { Button = b }
        function api.SetActive(v)
            if active ~= v then
                active = v
                paint()
            end
        end
        function api.IsActive() return active end
        return api
    end

    function UI.Drag(handle, target)
        local dragging, dragStart, startPos
        handle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = target.Position
            end
        end)
        Connect(UserInputService.InputChanged, function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local d = input.Position - dragStart
                target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
            end
        end)
        Connect(UserInputService.InputEnded, function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
    end

    function UI.Resize(grip, target, minW, minH, maxW, maxH)
        local resizing, startPos, startSize
        grip.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                resizing = true
                startPos = input.Position
                startSize = target.AbsoluteSize
            end
        end)
        Connect(UserInputService.InputChanged, function(input)
            if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local d = input.Position - startPos
                local w = math.clamp(startSize.X + d.X, minW, maxW)
                local h = math.clamp(startSize.Y + d.Y, minH, maxH)
                target.Size = UDim2.new(0, w, 0, h)
            end
        end)
        Connect(UserInputService.InputEnded, function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                resizing = false
            end
        end)
    end

    function UI.Esc(s)
        s = tostring(s or "")
        s = string.gsub(s, "&", "&amp;")
        s = string.gsub(s, "<", "&lt;")
        s = string.gsub(s, ">", "&gt;")
        return s
    end

    function UI.Rgb(c)
        return string.format("rgb(%d,%d,%d)", math.floor(c.R * 255 + 0.5), math.floor(c.G * 255 + 0.5), math.floor(c.B * 255 + 0.5))
    end

    function UI.IdStr(n)
        return string.format("%.0f", n)
    end

    local FriendCache = {}
    function UI.IsFriend(p)
        if p == LP then return false end
        local v = FriendCache[p]
        if v == nil then
            FriendCache[p] = false
            task.spawn(function()
                local ok, res = pcall(function() return LP:IsFriendsWith(p.UserId) end)
                FriendCache[p] = (ok and res) and true or false
            end)
            return false
        end
        return v
    end

    function UI.HeldTool(p)
        local ch = p.Character
        local t = ch and ch:FindFirstChildOfClass("Tool")
        return t and t.Name or nil
    end

    local Busts = {}
    function UI.GetBust(userId)
        if Busts[userId] then return Busts[userId] end
        local ok, img = pcall(function()
            return (Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size150x150))
        end)
        if ok and img then
            Busts[userId] = img
            return img
        end
        return ""
    end

    function UI.StyleFont(d)
        if not UI.FaceFamily then return end
        pcall(function()
            local w = d:GetAttribute("hxw")
            if not w then
                local f = d.Font
                w = "Regular"
                if f == Enum.Font.GothamBold or f == Enum.Font.GothamBlack then w = "Bold"
                elseif f == Enum.Font.GothamMedium then w = "Medium" end
                d:SetAttribute("hxw", w)
            end
            d.FontFace = Font.new(UI.FaceFamily, Enum.FontWeight[w], Enum.FontStyle.Normal)
        end)
    end

    function UI.Grad(inst, ka, kb, rot)
        if inst:IsA("UIStroke") then
            inst.Color = Color3.new(1, 1, 1)
        elseif inst:IsA("GuiObject") then
            inst.BackgroundColor3 = Color3.new(1, 1, 1)
        end
        local g = Instance.new("UIGradient")
        g.Color = ColorSequence.new(C[ka], C[kb])
        g.Rotation = rot or 0
        g.Parent = inst
        table.insert(UI.Binds, { grad = g, a = ka, b = kb })
        return g
    end

    function UI.PruneBinds()
        for i = #UI.Binds, 1, -1 do
            local b = UI.Binds[i]
            local target = b.grad or b.inst
            if not target or not target.Parent then table.remove(UI.Binds, i) end
        end
    end

    function UI.ApplyTheme(pal)
        local function key(c)
            return math.floor(c.R * 255 + 0.5) * 65536 + math.floor(c.G * 255 + 0.5) * 256 + math.floor(c.B * 255 + 0.5)
        end
        local map = {}
        for k, nc in pairs(pal) do
            local oc = C[k]
            if oc and typeof(nc) == "Color3" then map[key(oc)] = nc end
        end
        local function remap(inst, prop)
            local m = map[key(inst[prop])]
            if m then inst[prop] = m end
        end
        for _, g in ipairs(UI.Guis) do
            for _, d in ipairs(g:GetDescendants()) do
                pcall(function()
                    if d:IsA("UIStroke") then
                        remap(d, "Color")
                    elseif d:IsA("GuiObject") then
                        remap(d, "BackgroundColor3")
                        if d:IsA("TextLabel") or d:IsA("TextButton") then
                            remap(d, "TextColor3")
                        elseif d:IsA("TextBox") then
                            remap(d, "TextColor3")
                            remap(d, "PlaceholderColor3")
                        elseif d:IsA("ScrollingFrame") then
                            remap(d, "ScrollBarImageColor3")
                        end
                    end
                end)
            end
        end
        for k, nc in pairs(pal) do C[k] = nc end
        UI.PruneBinds()
        for _, b in ipairs(UI.Binds) do
            pcall(function()
                if b.grad then
                    b.grad.Color = ColorSequence.new(C[b.a], C[b.b])
                else
                    b.inst[b.prop] = C[b.key]
                end
            end)
        end
        if UpdateListState then pcall(UpdateListState) end
    end

    function UI.SyncTheme()
        local bg, face
        pcall(function()
            local bestArea = 0
            for _, g in ipairs(GuiParent():GetChildren()) do
                if g:IsA("ScreenGui") and g ~= PL.Gui and g ~= LibGui and g ~= CardGui and g.Name ~= "HexionHUD" then
                    for _, d in ipairs(g:GetDescendants()) do
                        if d:IsA("Frame") and d.BackgroundTransparency < 0.4 then
                            local sz = d.AbsoluteSize
                            if sz.X > 300 and sz.Y > 200 and sz.X * sz.Y > bestArea then
                                bestArea = sz.X * sz.Y
                                bg = d.BackgroundColor3
                            end
                        elseif not face and d:IsA("TextLabel") and d.Text ~= "" then
                            face = d.FontFace
                        end
                    end
                end
            end
        end)
        if not bg then return false end
        if (0.299 * bg.R + 0.587 * bg.G + 0.114 * bg.B) > 0.4 then return false end

        local function lift(a) return bg:Lerp(Color3.new(1, 1, 1), a) end
        local pal = {}
        for k, v in pairs(C) do pal[k] = v end
        pal.BG, pal.PANEL, pal.CARD = bg, lift(0.025), lift(0.055)
        pal.HOVER, pal.CHIP, pal.STROKE = lift(0.095), lift(0.12), lift(0.17)

        if face then UI.FaceFamily = face.Family end
        UI.ApplyTheme(pal)
        if face then
            for _, g in ipairs(UI.Guis) do
                for _, d in ipairs(g:GetDescendants()) do
                    pcall(function()
                        if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then UI.StyleFont(d) end
                    end)
                end
            end
        end
        return true
    end
end

do
    local function BuildLibrary()
        local C, New, Round, Stroke, Pad, Tween, Label, Button = UI.C, UI.New, UI.Round, UI.Stroke, UI.Pad, UI.Tween, UI.Label, UI.Button
        local IdStr = UI.IdStr

        local FOLDER = "Hexion"
        local CACHE_FILE = FOLDER .. "/catalog_cache.json"
        local FAV_FILE = FOLDER .. "/favorites.json"
        local CACHE_TTL = 60 * 60 * 24 * 3

        local canFile = (type(writefile) == "function") and (type(readfile) == "function") and (type(isfile) == "function")

        local function ReadJson(path)
            if not canFile then return nil end
            local ok, res = pcall(function()
                if isfile(path) then return HttpService:JSONDecode(readfile(path)) end
                return nil
            end)
            if ok then return res end
            return nil
        end

        local function WriteJson(path, data)
            if not canFile then return end
            pcall(function()
                if makefolder and isfolder and not isfolder(FOLDER) then makefolder(FOLDER) end
                writefile(path, HttpService:JSONEncode(data))
            end)
        end

        local S = {
            Emotes = {},
            Bundles = {},
            EmoteList = {},
            PackList = {},
            Loading = false,
            Fetched = false,
            Tab = "emote",
            Query = "",
            Page = 1,
            PerPage = 24,
            Favs = {},
            Selected = nil,
            Resolved = {},
        }

        local favData = ReadJson(FAV_FILE)
        if type(favData) == "table" then S.Favs = favData end
        local function SaveFavs() WriteJson(FAV_FILE, S.Favs) end

        local Hosts = { "https://catalog.roblox.com", "https://catalog.roproxy.com" }

        local function RawGet(url)
            local ok, res = pcall(function() return game:HttpGet(url) end)
            if ok and type(res) == "string" and #res > 0 then return res end
            local req = (syn and syn.request) or request or http_request
            if req then
                local ok2, r = pcall(function() return req({ Url = url, Method = "GET" }) end)
                if ok2 and r and type(r.Body) == "string" and (r.StatusCode == nil or r.StatusCode == 200) then
                    return r.Body
                end
            end
            return nil
        end

        local function CatalogGet(path)
            for _, host in ipairs(Hosts) do
                for attempt = 1, 3 do
                    local body = RawGet(host .. path)
                    if body then
                        local ok, data = pcall(function() return HttpService:JSONDecode(body) end)
                        if ok and type(data) == "table" and not data.errors then return data end
                    end
                    task.wait(0.6 * attempt)
                end
            end
            return nil
        end

        local function FetchCategory(sub, onProgress)
            local out, seen, cursor, pages = {}, {}, nil, 0
            while pages < 120 do
                pages += 1
                local path = "/v1/search/items/details?Category=12&Subcategory=" .. sub .. "&Limit=30&SortType=1&SortAggregation=5"
                if cursor then path = path .. "&Cursor=" .. HttpService:UrlEncode(cursor) end
                local data = CatalogGet(path)
                if not data or type(data.data) ~= "table" then break end
                for _, it in ipairs(data.data) do
                    if it.id and it.name and not seen[it.id] then
                        seen[it.id] = true
                        table.insert(out, { id = it.id, name = it.name, by = it.creatorName or "" })
                    end
                end
                if onProgress then onProgress(#out) end
                cursor = data.nextPageCursor
                if type(cursor) ~= "string" or cursor == "" then break end
                task.wait(0.25)
            end
            return out
        end

        local SlotKeywords = { "climb", "fall", "idle", "jump", "run", "walk", "swim" }
        local function ResolveBundle(bundleId)
            local key = IdStr(bundleId)
            if S.Resolved[key] then return S.Resolved[key] end
            local data = CatalogGet("/v1/bundles/" .. key .. "/details")
            if not data or type(data.items) ~= "table" then return nil end
            local pack = {}
            for _, it in ipairs(data.items) do
                if it.id and it.name and (it.type == nil or it.type == "Asset") then
                    local n = string.lower(it.name)
                    for _, kw in ipairs(SlotKeywords) do
                        if string.find(n, kw, 1, true) and not pack[kw] then
                            pack[kw] = it.id
                            break
                        end
                    end
                end
            end
            S.Resolved[key] = pack
            return pack
        end

        LibGui = New("ScreenGui", { Name = "HexionLibrary", ResetOnSpawn = false, DisplayOrder = 51, Enabled = false })
        LibGui.Parent = GuiParent()
        table.insert(UI.Guis, LibGui)

        local Main = New("Frame", {
            Size = UDim2.new(0, 468, 0, 590),
            Position = UDim2.new(0.5, -234, 0.5, -295),
            BackgroundColor3 = C.BG,
            BorderSizePixel = 0,
        }, LibGui)
        Round(Main, 16)
        Stroke(Main, C.STROKE, 1.3, 0.1)

        local topBar = New("Frame", { Position = UDim2.new(0, 16, 0, 0), Size = UDim2.new(1, -32, 0, 2), BackgroundColor3 = C.ACCENT, BorderSizePixel = 0 }, Main)
        UI.Grad(topBar, "ACCENT", "ACCENT2", 0)

        local Header = New("Frame", { Size = UDim2.new(1, 0, 0, 62), BackgroundTransparency = 1 }, Main)
        local Logo = New("Frame", { Size = UDim2.new(0, 38, 0, 38), Position = UDim2.new(0, 14, 0, 14), BackgroundColor3 = C.ACCENT, BorderSizePixel = 0 }, Header)
        Round(Logo, 11)
        Label(Logo, { Size = UDim2.new(1, 0, 1, 0), Text = "H", Font = Enum.Font.GothamBold, TextSize = 20, TextColor3 = C.DARK, TextXAlignment = Enum.TextXAlignment.Center })
        Label(Header, { Position = UDim2.new(0, 62, 0, 11), Size = UDim2.new(1, -170, 0, 20), Text = "Kitaplık", Font = Enum.Font.GothamBold, TextSize = 17 })
        local Status = Label(Header, { Position = UDim2.new(0, 62, 0, 32), Size = UDim2.new(1, -170, 0, 14), Text = "Hazır", TextSize = 11, TextColor3 = C.DIM })

        local RefreshBtn = Button(Header, "Yenile", { Size = UDim2.new(0, 54, 0, 28), Position = UDim2.new(1, -114, 0, 17), TextSize = 11 })
        local CloseBtn = Button(Header, "X", { Size = UDim2.new(0, 28, 0, 28), Position = UDim2.new(1, -44, 0, 17), TextSize = 13 })
        CloseBtn.Button.MouseButton1Click:Connect(function() LibGui.Enabled = false end)
        UI.Drag(Header, Main)

        local TabDefs = { { "emote", "Emote'lar" }, { "pack", "Paketler" }, { "fav", "Favoriler" } }
        local TabBtns = {}
        for i, def in ipairs(TabDefs) do
            local api = Button(Main, def[2], {
                Size = UDim2.new(1 / 3, -10, 0, 30),
                Position = UDim2.new((i - 1) / 3, 10 + ((i - 1) * 0), 0, 66),
                TextSize = 12,
            })
            TabBtns[def[1]] = { Api = api, Title = def[2] }
        end

        local Search = New("TextBox", {
            Size = UDim2.new(1, -20, 0, 34),
            Position = UDim2.new(0, 10, 0, 102),
            BackgroundColor3 = C.CARD,
            BorderSizePixel = 0,
            Font = Enum.Font.Gotham,
            TextSize = 13,
            TextColor3 = C.TEXT,
            TextXAlignment = Enum.TextXAlignment.Left,
            PlaceholderText = "Ara… (isim)",
            PlaceholderColor3 = C.DIM,
            Text = "",
            ClearTextOnFocus = false,
        }, Main)
        Round(Search, 10)
        local SearchStroke = Stroke(Search, C.STROKE, 1)
        Pad(Search, 14, 0, 14, 0)
        Search.Focused:Connect(function() SearchStroke.Color = C.ACCENT end)
        Search.FocusLost:Connect(function() SearchStroke.Color = C.STROKE end)

        local Grid = New("ScrollingFrame", {
            Position = UDim2.new(0, 10, 0, 144),
            Size = UDim2.new(1, -20, 1, -(144 + 92)),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = C.FAINT,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
        }, Main)
        local GridLayout = New("UIGridLayout", {
            CellSize = UDim2.new(0, 104, 0, 126),
            CellPadding = UDim2.new(0, 8, 0, 8),
            SortOrder = Enum.SortOrder.LayoutOrder,
        }, Grid)

        local Empty = Label(Main, {
            Position = UDim2.new(0, 10, 0.5, -20),
            Size = UDim2.new(1, -20, 0, 40),
            Text = "Sonuç yok",
            TextColor3 = C.DIM,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Center,
            Visible = false,
        })

        local PrevBtn = Button(Main, "<", { Size = UDim2.new(0, 34, 0, 26), Position = UDim2.new(0, 10, 1, -80), TextSize = 16 })
        local NextBtn = Button(Main, ">", { Size = UDim2.new(0, 34, 0, 26), Position = UDim2.new(1, -44, 1, -80), TextSize = 16 })
        local PageLabel = Label(Main, {
            Position = UDim2.new(0, 50, 1, -80),
            Size = UDim2.new(1, -100, 0, 26),
            Text = "1 / 1",
            TextXAlignment = Enum.TextXAlignment.Center,
            TextColor3 = C.DIM,
        })

        local Bar = New("Frame", { Position = UDim2.new(0, 10, 1, -46), Size = UDim2.new(1, -20, 0, 36), BackgroundColor3 = C.PANEL, BorderSizePixel = 0 }, Main)
        Round(Bar, 10)
        Stroke(Bar, C.STROKE, 1, 0.3)

        local used = 6
        local function place(w)
            used = used + w
            local pos = UDim2.new(1, -used, 0.5, -14)
            used = used + 5
            return pos
        end
        local PlusBtn = Button(Bar, "+", { Size = UDim2.new(0, 28, 0, 28), Position = place(28), TextSize = 15 })
        local SpeedLabel = Label(Bar, { Size = UDim2.new(0, 40, 0, 28), Position = place(40), Text = "1.0x", TextXAlignment = Enum.TextXAlignment.Center, TextColor3 = C.DIM })
        local MinusBtn = Button(Bar, "-", { Size = UDim2.new(0, 28, 0, 28), Position = place(28), TextSize = 15 })
        local LoopBtn = Button(Bar, "Döngü", { Size = UDim2.new(0, 56, 0, 28), Position = place(56), TextSize = 11 })
        local StopBtn = Button(Bar, "Durdur", { Size = UDim2.new(0, 70, 0, 28), Position = place(70), TextSize = 11 })
        local NowLabel = Label(Bar, {
            Position = UDim2.new(0, 12, 0, 0),
            Size = UDim2.new(1, -(used + 8), 1, 0),
            Text = "Bir emote veya paket seç",
            TextColor3 = C.DIM,
            TextSize = 11,
        })

        local Grip = Label(Main, {
            Position = UDim2.new(1, -4, 1, -4),
            Size = UDim2.new(0, 1, 0, 1),
            Text = "",
            Visible = false,
        })

        local function FavKey(item) return item.kind .. ":" .. tostring(item.id) end

        local function BuildLists()
            local seen, em = {}, {}
            for _, name in ipairs(EmoteNames) do
                local id = Emotes[name]
                if id then
                    seen[id] = true
                    table.insert(em, { kind = "emote", id = id, name = name, low = string.lower(name) })
                end
            end
            for _, it in ipairs(S.Emotes) do
                if not seen[it.id] then
                    seen[it.id] = true
                    table.insert(em, { kind = "emote", id = it.id, name = it.name, by = it.by, low = string.lower(it.name) })
                end
            end
            S.EmoteList = em

            local pk = {}
            for _, name in ipairs(PackNames) do
                table.insert(pk, { kind = "lpack", id = name, name = name, low = string.lower(name) })
            end
            for _, it in ipairs(S.Bundles) do
                table.insert(pk, { kind = "bundle", id = it.id, name = it.name, by = it.by, low = string.lower(it.name) })
            end
            S.PackList = pk
        end

        local function FavList()
            local out = {}
            for _, f in pairs(S.Favs) do
                if type(f) == "table" and f.kind and f.id and f.name then
                    table.insert(out, { kind = f.kind, id = f.id, name = f.name, by = f.by, low = string.lower(f.name) })
                end
            end
            table.sort(out, function(a, b) return a.low < b.low end)
            return out
        end

        local function CountFavs()
            local n = 0
            for _ in pairs(S.Favs) do n += 1 end
            return n
        end

        local function CurrentList()
            local src
            if S.Tab == "emote" then src = S.EmoteList
            elseif S.Tab == "pack" then src = S.PackList
            else src = FavList() end
            local q = string.lower(S.Query or "")
            if q == "" then return src end
            local out = {}
            for _, it in ipairs(src) do
                if string.find(it.low, q, 1, true) then table.insert(out, it) end
            end
            return out
        end

        local function ThumbFor(item)
            if item.kind == "emote" then
                return "rbxthumb://type=Asset&id=" .. IdStr(item.id) .. "&w=150&h=150"
            elseif item.kind == "bundle" then
                return "rbxthumb://type=BundleThumbnail&id=" .. IdStr(item.id) .. "&w=150&h=150"
            end
            return ""
        end

        local Cells = {}
        local Render

        local function PlayCatalogEmote(item)
            PlayAnimation(item.id)
            local tr = CurrentTrack
            if tr then
                NowLabel.Text = "Çalıyor: " .. item.name
                NowLabel.TextColor3 = C.TEXT
                task.delay(0.9, function()
                    if CurrentTrack == tr and tr.Length == 0 then
                        Notify("Emote", item.name .. " yüklenemedi (R15 gerekebilir veya izin yok).", "Warning")
                        NowLabel.Text = "Hata: " .. item.name .. " oynatılamadı"
                    end
                end)
            end
        end

        local function Activate(item, key)
            S.Selected = key
            for k, st in pairs(Cells) do
                st.Transparency = (k == key) and 0.15 or 1
            end
            if item.kind == "emote" then
                PlayCatalogEmote(item)
            elseif item.kind == "lpack" then
                if ApplyPackTable(Packs[item.id], item.name) then
                    NowLabel.Text = "Paket: " .. item.name
                    NowLabel.TextColor3 = C.TEXT
                end
            elseif item.kind == "bundle" then
                Notify("Paketler", item.name .. " çözümleniyor…", "Info")
                task.spawn(function()
                    local pack = ResolveBundle(item.id)
                    if pack and next(pack) then
                        if ApplyPackTable(pack, item.name) then
                            NowLabel.Text = "Paket: " .. item.name
                            NowLabel.TextColor3 = C.TEXT
                        end
                    else
                        Notify("Paketler", "Paket içeriği alınamadı.", "Error")
                    end
                end)
            end
        end

        local function MakeCell(item, index)
            local key = FavKey(item)
            local cell = New("TextButton", {
                Text = "",
                AutoButtonColor = false,
                BackgroundColor3 = C.CARD,
                BorderSizePixel = 0,
                LayoutOrder = index,
            })
            Round(cell, 10)
            local st = Stroke(cell, C.ACCENT, 1.5, (S.Selected == key) and 0.15 or 1)
            Cells[key] = st

            local img = New("ImageLabel", {
                Size = UDim2.new(1, -12, 0, 78),
                Position = UDim2.new(0, 6, 0, 6),
                BackgroundColor3 = C.CHIP,
                BorderSizePixel = 0,
                Image = ThumbFor(item),
                ScaleType = Enum.ScaleType.Fit,
            }, cell)
            Round(img, 8)
            if item.kind == "lpack" then
                Label(img, {
                    Size = UDim2.new(1, 0, 1, 0),
                    Text = string.upper(string.sub(item.name, 1, 1)),
                    Font = Enum.Font.GothamBold,
                    TextSize = 30,
                    TextColor3 = C.ACCENT,
                    TextXAlignment = Enum.TextXAlignment.Center,
                })
            end

            Label(cell, {
                Position = UDim2.new(0, 5, 0, 88),
                Size = UDim2.new(1, -10, 0, 32),
                Text = item.name,
                Font = Enum.Font.GothamMedium,
                TextSize = 11,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Top,
            })

            local isFav = S.Favs[key] ~= nil
            local star = New("TextButton", {
                Size = UDim2.new(0, 22, 0, 22),
                Position = UDim2.new(1, -28, 0, 8),
                BackgroundColor3 = C.BG,
                BackgroundTransparency = 0.3,
                BorderSizePixel = 0,
                AutoButtonColor = false,
                Font = Enum.Font.GothamBold,
                TextSize = 13,
                Text = "",
                TextColor3 = isFav and C.WARN or C.TEXT,
                ZIndex = 3,
            }, cell)
            Round(star, 11)
            Theme.DrawIcon(star, "star", isFav and C.WARN or C.TEXT, 15, isFav)
            star.MouseButton1Click:Connect(function()
                if S.Favs[key] then
                    S.Favs[key] = nil
                else
                    S.Favs[key] = { kind = item.kind, id = item.id, name = item.name, by = item.by }
                end
                SaveFavs()
                if S.Tab == "fav" then
                    Render()
                else
                    local now = S.Favs[key] ~= nil
                    Theme.DrawIcon(star, "star", now and C.WARN or C.TEXT, 15, now)
                    star.TextColor3 = now and C.WARN or C.TEXT
                    TabBtns.fav.Api.Button.Text = "Favoriler · " .. CountFavs()
                end
            end)

            cell.MouseButton1Click:Connect(function() Activate(item, key) end)
            cell.MouseEnter:Connect(function() Tween(cell, 0.12, { BackgroundColor3 = C.HOVER }) end)
            cell.MouseLeave:Connect(function() Tween(cell, 0.12, { BackgroundColor3 = C.CARD }) end)
            cell.Parent = Grid
        end

        Render = function()
            local list = CurrentList()
            local total = #list
            local pages = math.max(1, math.ceil(total / S.PerPage))
            S.Page = math.clamp(S.Page, 1, pages)

            for _, c in ipairs(Grid:GetChildren()) do
                if c:IsA("TextButton") then c:Destroy() end
            end
            Cells = {}

            local first = (S.Page - 1) * S.PerPage + 1
            local last = math.min(total, first + S.PerPage - 1)
            for i = first, last do
                MakeCell(list[i], i)
            end
            Grid.CanvasPosition = Vector2.new(0, 0)
            Empty.Visible = (total == 0)
            if total == 0 then
                Empty.Text = (S.Tab == "fav") and "Henüz favori yok — yıldız ile ekle" or "Sonuç yok"
            end
            PageLabel.Text = S.Page .. " / " .. pages .. "  ·  " .. total .. " sonuç"

            TabBtns.emote.Api.Button.Text = "Emote'lar · " .. #S.EmoteList
            TabBtns.pack.Api.Button.Text = "Paketler · " .. #S.PackList
            TabBtns.fav.Api.Button.Text = "Favoriler · " .. CountFavs()
            for id, t in pairs(TabBtns) do t.Api.SetActive(id == S.Tab) end
        end

        for id, t in pairs(TabBtns) do
            t.Api.Button.MouseButton1Click:Connect(function()
                S.Tab = id
                S.Page = 1
                Render()
            end)
        end

        PrevBtn.Button.MouseButton1Click:Connect(function() S.Page -= 1 Render() end)
        NextBtn.Button.MouseButton1Click:Connect(function() S.Page += 1 Render() end)

        Search:GetPropertyChangedSignal("Text"):Connect(function()
            S.Query = Search.Text
            S.Page = 1
            Render()
        end)

        local function RefreshControls()
            SpeedLabel.Text = string.format("%.1fx", AnimSpeed)
            LoopBtn.SetActive(EmoteLoop)
        end
        StopBtn.Button.MouseButton1Click:Connect(function()
            StopCustom()
            NowLabel.Text = "Durduruldu"
            NowLabel.TextColor3 = C.DIM
        end)
        LoopBtn.Button.MouseButton1Click:Connect(function()
            EmoteLoop = not EmoteLoop
            if CurrentTrack then CurrentTrack.Looped = EmoteLoop end
            RefreshControls()
        end)
        local function SetSpeed(v)
            AnimSpeed = math.clamp(math.floor(v * 10 + 0.5) / 10, 0, 5)
            if CurrentTrack then pcall(function() CurrentTrack:AdjustSpeed(AnimSpeed) end) end
            RefreshControls()
        end
        MinusBtn.Button.MouseButton1Click:Connect(function() SetSpeed(AnimSpeed - 0.1) end)
        PlusBtn.Button.MouseButton1Click:Connect(function() SetSpeed(AnimSpeed + 0.1) end)

        local function SetStatus(t) Status.Text = t end

        local function LoadData(force)
            if S.Loading then return end
            S.Loading = true
            RefreshBtn.Button.Text = "…"
            task.spawn(function()
                local cache = (not force) and ReadJson(CACHE_FILE) or nil
                if cache and type(cache.t) == "number" and (os.time() - cache.t) < CACHE_TTL
                    and type(cache.emotes) == "table" and #cache.emotes > 0 then
                    S.Emotes = cache.emotes
                    S.Bundles = type(cache.bundles) == "table" and cache.bundles or {}
                    S.Fetched = true
                    BuildLists()
                    Render()
                    SetStatus(#S.Emotes .. " emote · " .. #S.Bundles .. " paket (önbellek)")
                else
                    SetStatus("Emote'lar yükleniyor…")
                    local emotes = FetchCategory(39, function(n) SetStatus("Emote'lar yükleniyor… " .. n) end)
                    if #emotes > 0 then
                        S.Emotes = emotes
                        BuildLists()
                        Render()
                    end
                    SetStatus("Animasyon paketleri yükleniyor…")
                    local bundles = FetchCategory(38, function(n) SetStatus("Paketler yükleniyor… " .. n) end)
                    if #emotes == 0 and #bundles == 0 then
                        SetStatus("Katalog alınamadı — yerleşik liste gösteriliyor")
                        Notify("Kitaplık", "Roblox kataloğuna ulaşılamadı. Executor'ın HttpGet desteğini kontrol et.", "Warning")
                    else
                        S.Emotes = emotes
                        S.Bundles = bundles
                        S.Fetched = true
                        WriteJson(CACHE_FILE, { t = os.time(), emotes = emotes, bundles = bundles })
                        SetStatus(#emotes .. " emote · " .. #bundles .. " paket")
                    end
                    BuildLists()
                    Render()
                end
                S.Loading = false
                RefreshBtn.Button.Text = "Yenile"
            end)
        end

        RefreshBtn.Button.MouseButton1Click:Connect(function() LoadData(true) end)

        BuildLists()
        Render()
        RefreshControls()

        LibraryAPI.Toggle = function()
            LibGui.Enabled = not LibGui.Enabled
            if LibGui.Enabled then
                RefreshControls()
                if not S.Fetched and not S.Loading then LoadData(false) end
            end
        end
        LibraryAPI.Open = function()
            LibGui.Enabled = true
            RefreshControls()
            if not S.Fetched and not S.Loading then LoadData(false) end
        end
    end

    BuildLibrary()
end

do
    local function BuildPlayerList()
        local C, New, Round, Stroke, Pad, Tween, Label = UI.C, UI.New, UI.Round, UI.Stroke, UI.Pad, UI.Tween, UI.Label
        local Esc, Rgb, IsFriend, HeldTool, GetBust, Grad = UI.Esc, UI.Rgb, UI.IsFriend, UI.HeldTool, UI.GetBust, UI.Grad

        local HEADER_H = 70
        local SEARCH_Y = 4
        local CHIPS_Y = 48
        local LIST_Y = 90
        local FOOTER_H = 32
        local DETAIL_H = 232
        local ROW_H = 68
        local NEAR_DIST = 150
        local MIN_W, MIN_H = 440, 540
        local WHITE = Color3.new(1, 1, 1)

        PL.Gui = New("ScreenGui", { Name = "HexionPlayerList", ResetOnSpawn = false, DisplayOrder = 50, Enabled = true })
        PL.Gui.Parent = GuiParent()
        table.insert(UI.Guis, PL.Gui)

        local DEFAULT_POS = UDim2.new(0, 16, 0.5, -320)
        local DEFAULT_SIZE = UDim2.new(0, 460, 0, 640)
        local Main = New("Frame", { Name = "Main", Size = DEFAULT_SIZE, Position = DEFAULT_POS, BackgroundColor3 = C.BG, BorderSizePixel = 0 }, PL.Gui)
        Round(Main, 18)
        local MainStroke = Stroke(Main, C.ACCENT, 1.5, 0.3)
        Grad(MainStroke, "ACCENT", "ACCENT2", 35)

        local GlowTop = New("Frame", { Size = UDim2.new(1, 0, 0, 160), BackgroundColor3 = C.ACCENT, BorderSizePixel = 0 }, Main)
        Round(GlowTop, 18)
        local gt = Instance.new("UIGradient")
        gt.Rotation = 90
        gt.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.78), NumberSequenceKeypoint.new(1, 1) })
        gt.Parent = GlowTop
        local GlowBot = New("Frame", { AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 0, 1, 0), Size = UDim2.new(1, 0, 0, 150), BackgroundColor3 = C.ACCENT2, BorderSizePixel = 0 }, Main)
        Round(GlowBot, 18)
        local gb = Instance.new("UIGradient")
        gb.Rotation = 90
        gb.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0.84) })
        gb.Parent = GlowBot

        local function IconBtn(parent, text, pos, hoverKey)
            local b = New("TextButton", {
                Size = UDim2.new(0, 28, 0, 28), Position = pos, BackgroundColor3 = C.CARD, BorderSizePixel = 0,
                AutoButtonColor = false, Font = Enum.Font.GothamBold, TextSize = 12, TextColor3 = C.DIM, Text = text,
            }, parent)
            Round(b, 14)
            Stroke(b, C.STROKE, 1, 0.5)
            UI.StyleFont(b)
            b.MouseEnter:Connect(function() Tween(b, 0.12, { BackgroundColor3 = C.HOVER, TextColor3 = C[hoverKey or "TEXT"] }) end)
            b.MouseLeave:Connect(function() Tween(b, 0.12, { BackgroundColor3 = C.CARD, TextColor3 = C.DIM }) end)
            return b
        end

        local function GButton(parent, text, props, style)
            local pr = { AutoButtonColor = false, BackgroundColor3 = C.CHIP, BorderSizePixel = 0, Font = Enum.Font.GothamMedium, TextSize = 11, TextColor3 = C.DIM, Text = text }
            for k, v in pairs(props or {}) do pr[k] = v end
            local b = New("TextButton", pr)
            Round(b, 9)
            b.Parent = parent
            UI.StyleFont(b)
            local active, hover = false, false
            local activeKey = (style == "blue") and "ACCENT2" or "ACCENT"
            local function paint()
                local bg, fg
                if style == "primary" then
                    bg = hover and C.ACCENT:Lerp(WHITE, 0.14) or C.ACCENT
                    fg = C.DARK
                elseif active then
                    bg = hover and C[activeKey]:Lerp(WHITE, 0.14) or C[activeKey]
                    fg = C.DARK
                else
                    bg = hover and C.HOVER or C.CHIP
                    fg = hover and C.TEXT or C.DIM
                end
                Tween(b, 0.12, { BackgroundColor3 = bg, TextColor3 = fg })
            end
            b.MouseEnter:Connect(function() hover = true paint() end)
            b.MouseLeave:Connect(function() hover = false paint() end)
            paint()
            local api = { Button = b }
            function api.SetActive(v)
                if active ~= v then
                    active = v
                    paint()
                end
            end
            function api.IsActive() return active end
            return api
        end

        local Header = New("Frame", { Size = UDim2.new(1, 0, 0, HEADER_H), BackgroundTransparency = 1 }, Main)
        local Logo = New("Frame", { Size = UDim2.new(0, 42, 0, 42), Position = UDim2.new(0, 16, 0, 14), BackgroundColor3 = C.ACCENT, BorderSizePixel = 0 }, Header)
        Round(Logo, 13)
        Grad(Logo, "ACCENT", "ACCENT2", 45)
        Label(Logo, { Size = UDim2.new(1, 0, 1, 0), Text = "H", Font = Enum.Font.GothamBlack, TextSize = 21, TextColor3 = C.DARK, TextXAlignment = Enum.TextXAlignment.Center })
        Label(Header, { Position = UDim2.new(0, 70, 0, 13), Size = UDim2.new(1, -260, 0, 22), Text = "Oyuncular", Font = Enum.Font.GothamBold, TextSize = 19 })
        local HGame = Label(Header, { Position = UDim2.new(0, 70, 0, 36), Size = UDim2.new(1, -260, 0, 14), Text = GameName, TextSize = 11, TextColor3 = C.DIM })

        local MinBtn = IconBtn(Header, "—", UDim2.new(1, -78, 0, 21))
        local CloseBtn = IconBtn(Header, "X", UDim2.new(1, -44, 0, 21), "BAD")
        CloseBtn.MouseButton1Click:Connect(function() PL.Gui.Enabled = false end)

        local CountPill = New("Frame", { Size = UDim2.new(0, 92, 0, 26), Position = UDim2.new(1, -(14 + 28 + 6 + 28 + 10 + 92), 0, 22), BackgroundColor3 = C.CARD, BorderSizePixel = 0 }, Header)
        Round(CountPill, 13)
        Stroke(CountPill, C.STROKE, 1, 0.5)
        local PillDot = New("Frame", { Size = UDim2.new(0, 7, 0, 7), Position = UDim2.new(0, 11, 0.5, -3), BackgroundColor3 = C.ACCENT2, BorderSizePixel = 0 }, CountPill)
        Round(PillDot, 4)
        local HCount = Label(CountPill, { Position = UDim2.new(0, 25, 0, 0), Size = UDim2.new(1, -30, 1, 0), Text = "0 oyuncu", TextSize = 11, Font = Enum.Font.GothamMedium })
        UI.Drag(Header, Main)

        local Body = New("Frame", { Position = UDim2.new(0, 0, 0, HEADER_H), Size = UDim2.new(1, 0, 1, -HEADER_H), BackgroundTransparency = 1 }, Main)

        local SearchWrap = New("Frame", { Size = UDim2.new(1, -28, 0, 38), Position = UDim2.new(0, 14, 0, SEARCH_Y), BackgroundColor3 = C.CARD, BorderSizePixel = 0 }, Body)
        Round(SearchWrap, 13)
        local SearchStroke = Stroke(SearchWrap, C.STROKE, 1, 0.3)
        local SIcon = New("Frame", { Position = UDim2.new(0, 14, 0, 0), Size = UDim2.new(0, 20, 1, 0), BackgroundTransparency = 1 }, SearchWrap)
        Theme.DrawIcon(SIcon, "search", C.ACCENT, 16)
        local Search = New("TextBox", {
            Position = UDim2.new(0, 40, 0, 0), Size = UDim2.new(1, -76, 1, 0), BackgroundTransparency = 1,
            Font = Enum.Font.Gotham, TextSize = 13, TextColor3 = C.TEXT, TextXAlignment = Enum.TextXAlignment.Left,
            PlaceholderText = "Oyuncu ara…  (isim veya @kullanıcı adı)", PlaceholderColor3 = C.FAINT, Text = "", ClearTextOnFocus = false,
        }, SearchWrap)
        UI.StyleFont(Search)
        local ClearBtn = New("TextButton", {
            Size = UDim2.new(0, 22, 0, 22), Position = UDim2.new(1, -30, 0.5, -11), BackgroundTransparency = 1,
            Text = "X", Font = Enum.Font.GothamBold, TextSize = 11, TextColor3 = C.FAINT, AutoButtonColor = false, Visible = false,
        }, SearchWrap)
        ClearBtn.MouseButton1Click:Connect(function() Search.Text = "" end)
        Search.Focused:Connect(function() Tween(SearchStroke, 0.12, { Color = C.ACCENT, Transparency = 0 }) end)
        Search.FocusLost:Connect(function() Tween(SearchStroke, 0.12, { Color = C.STROKE, Transparency = 0.3 }) end)

        local MODES = { "Hepsi", "Arkadaş", "Yakın", "İşaretli" }
        local Seg = New("Frame", { Size = UDim2.new(1, -(28 + 120 + 8), 0, 32), Position = UDim2.new(0, 14, 0, CHIPS_Y), BackgroundColor3 = C.PANEL, BorderSizePixel = 0 }, Body)
        Round(Seg, 16)
        Stroke(Seg, C.STROKE, 1, 0.5)
        local SegInner = New("Frame", { Size = UDim2.new(1, -6, 1, -6), Position = UDim2.new(0, 3, 0, 3), BackgroundTransparency = 1 }, Seg)
        local SegHi = New("Frame", { Size = UDim2.new(1 / #MODES, 0, 1, 0), BackgroundColor3 = C.ACCENT, BorderSizePixel = 0 }, SegInner)
        Round(SegHi, 13)
        Grad(SegHi, "ACCENT", "ACCENT2", 0)
        local ModeBtns = {}
        for i, m in ipairs(MODES) do
            local b = New("TextButton", {
                Size = UDim2.new(1 / #MODES, 0, 1, 0), Position = UDim2.new((i - 1) / #MODES, 0, 0, 0), BackgroundTransparency = 1,
                Text = m, Font = Enum.Font.GothamMedium, TextSize = 11, TextColor3 = C.DIM, AutoButtonColor = false, ZIndex = 2,
            }, SegInner)
            UI.StyleFont(b)
            ModeBtns[m] = b
        end
        local function PaintModes(animate)
            for i, m in ipairs(MODES) do
                local on = (PL.Mode == m)
                if on then
                    local pos = UDim2.new((i - 1) / #MODES, 0, 0, 0)
                    if animate then Tween(SegHi, 0.2, { Position = pos }) else SegHi.Position = pos end
                end
                ModeBtns[m].TextColor3 = on and C.DARK or C.DIM
            end
        end
        PaintModes(false)

        local SORTS = { "Ad", "Mesafe", "Takım", "Can" }
        local SortBtn = New("TextButton", {
            Size = UDim2.new(0, 120, 0, 32), Position = UDim2.new(1, -(14 + 120), 0, CHIPS_Y), BackgroundColor3 = C.CARD, BorderSizePixel = 0,
            AutoButtonColor = false, Font = Enum.Font.GothamMedium, TextSize = 11, TextColor3 = C.TEXT, Text = "Sırala: " .. PL.Sort,
        }, Body)
        Round(SortBtn, 16)
        Stroke(SortBtn, C.STROKE, 1, 0.3)
        UI.StyleFont(SortBtn)
        SortBtn.MouseEnter:Connect(function() Tween(SortBtn, 0.12, { BackgroundColor3 = C.HOVER }) end)
        SortBtn.MouseLeave:Connect(function() Tween(SortBtn, 0.12, { BackgroundColor3 = C.CARD }) end)

        local Scroll = New("ScrollingFrame", {
            Position = UDim2.new(0, 8, 0, LIST_Y), Size = UDim2.new(1, -16, 1, -(LIST_Y + FOOTER_H)),
            BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 3, ScrollBarImageColor3 = C.ACCENT, ScrollBarImageTransparency = 0.35,
            CanvasSize = UDim2.new(0, 0, 0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y, ClipsDescendants = true,
        }, Body)
        New("UIListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }, Scroll)
        Pad(Scroll, 0, 4, 0, 4)

        local Empty = Label(Body, {
            Position = UDim2.new(0, 14, 0, LIST_Y + 44), Size = UDim2.new(1, -28, 0, 40),
            Text = "Eşleşen oyuncu yok", TextColor3 = C.FAINT, TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Center, Visible = false, TextWrapped = true,
        })

        local Detail = New("Frame", {
            AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 8, 1, -FOOTER_H),
            Size = UDim2.new(1, -16, 0, DETAIL_H), BackgroundColor3 = C.PANEL, BorderSizePixel = 0, Visible = false,
        }, Body)
        Round(Detail, 16)
        local DStroke = Stroke(Detail, C.ACCENT, 1.3, 0.4)
        Grad(DStroke, "ACCENT", "ACCENT2", 30)

        local Banner = New("Frame", { Size = UDim2.new(1, 0, 0, 78), BackgroundColor3 = C.ACCENT, BorderSizePixel = 0 }, Detail)
        Round(Banner, 16)
        local bn = Grad(Banner, "ACCENT", "ACCENT2", 20)
        bn.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.7), NumberSequenceKeypoint.new(1, 0.93) })

        local DImg = New("ImageLabel", { Size = UDim2.new(0, 84, 0, 84), Position = UDim2.new(0, 14, 0, 14), BackgroundColor3 = C.CHIP, BorderSizePixel = 0 }, Detail)
        Round(DImg, 18)
        local DRing = Stroke(DImg, C.ACCENT, 2.2)
        local DName = Label(Detail, { Position = UDim2.new(0, 112, 0, 12), Size = UDim2.new(1, -156, 0, 22), Font = Enum.Font.GothamBold, TextSize = 17, RichText = true, Text = "" })
        local DUser = Label(Detail, { Position = UDim2.new(0, 112, 0, 35), Size = UDim2.new(1, -126, 0, 14), TextColor3 = C.DIM, Text = "" })
        local DInfo1 = Label(Detail, { Position = UDim2.new(0, 112, 0, 52), Size = UDim2.new(1, -126, 0, 14), TextSize = 11, TextColor3 = C.DIM, RichText = true, Text = "" })
        local DInfo2 = Label(Detail, { Position = UDim2.new(0, 112, 0, 68), Size = UDim2.new(1, -126, 0, 14), TextSize = 11, TextColor3 = C.DIM, RichText = true, Text = "" })
        local DHpBack = New("Frame", { Position = UDim2.new(0, 112, 0, 92), Size = UDim2.new(1, -126, 0, 6), BackgroundColor3 = C.BG, BorderSizePixel = 0 }, Detail)
        Round(DHpBack, 3)
        local DHpFill = New("Frame", { Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = C.ACCENT2, BorderSizePixel = 0 }, DHpBack)
        Round(DHpFill, 3)
        local DHpText = Label(Detail, { Position = UDim2.new(0, 112, 0, 100), Size = UDim2.new(1, -126, 0, 12), TextSize = 10, TextColor3 = C.FAINT, Text = "" })
        local DClose = IconBtn(Detail, "X", UDim2.new(1, -40, 0, 10))
        DClose.Size = UDim2.new(0, 26, 0, 26)
        DClose.MouseButton1Click:Connect(function() SetTarget(nil) end)

        local BtnArea = New("Frame", { Position = UDim2.new(0, 12, 0, 120), Size = UDim2.new(1, -24, 0, DETAIL_H - 130), BackgroundTransparency = 1 }, Detail)
        local function dbtn(text, i, row, style)
            local h = (row == 1) and 34 or 26
            local y = (row == 1) and 0 or (row == 2 and 42 or 72)
            return GButton(BtnArea, text, { Size = UDim2.new(1 / 3, -4, 0, h), Position = UDim2.new((i - 1) / 3, 2, 0, y) }, style)
        end
        local dTP = dbtn("Işınlan", 1, 1, "primary")
        local dWatch = dbtn("İzle", 2, 1, "blue")
        local dListen = dbtn("Dinle", 3, 1, "pink")
        local dFollow = dbtn("Takip et", 1, 2, "pink")
        local dCopyAnim = dbtn("Anim. kopyala", 2, 2, "blue")
        local dMark = dbtn("ESP'de işaretle", 3, 2, "pink")
        local dCopyId = dbtn("ID kopyala", 1, 3, "ghost")
        local dCopyName = dbtn("İsim kopyala", 2, 3, "ghost")
        local dCopyLink = dbtn("Profil linki", 3, 3, "ghost")

        New("Frame", { Position = UDim2.new(0, 16, 1, -FOOTER_H), Size = UDim2.new(1, -32, 0, 1), BackgroundColor3 = C.STROKE, BackgroundTransparency = 0.5, BorderSizePixel = 0 }, Body)
        local Hint = Label(Body, { Position = UDim2.new(0, 18, 1, -FOOTER_H + 7), Size = UDim2.new(0.62, 0, 0, 18), Text = "", TextSize = 11, TextColor3 = C.FAINT })
        Label(Body, {
            Position = UDim2.new(0.5, 0, 1, -FOOTER_H + 7), Size = UDim2.new(0.5, -34, 0, 18),
            Text = "Hexion v9  ·  " .. CREATOR, TextSize = 11, TextColor3 = C.FAINT, TextXAlignment = Enum.TextXAlignment.Right,
        })

        local GripBtn = New("TextButton", {
            AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -5, 1, -5), Size = UDim2.new(0, 20, 0, 20),
            BackgroundTransparency = 1, Text = "", Font = Enum.Font.GothamBold, TextSize = 12,
            TextColor3 = C.ACCENT2, AutoButtonColor = false, ZIndex = 5,
        }, Main)
        Theme.DrawIcon(GripBtn, "grip", C.ACCENT2, 14)
        UI.Resize(GripBtn, Main, MIN_W, MIN_H, 640, 900)

        local Minimized, ExpandedSize = false, Main.Size
        MinBtn.MouseButton1Click:Connect(function()
            Minimized = not Minimized
            if Minimized then
                ExpandedSize = Main.Size
                Body.Visible = false
                GripBtn.Visible = false
                GlowBot.Visible = false
                Tween(Main, 0.18, { Size = UDim2.new(0, Main.Size.X.Offset, 0, HEADER_H) })
            else
                Body.Visible = true
                GripBtn.Visible = true
                GlowBot.Visible = true
                Tween(Main, 0.18, { Size = ExpandedSize })
            end
        end)

        local function DoTP(p)
            if TeleportToPlayer(p) then
                Notify("Işınlan", p.DisplayName .. " konumuna ışınlandın.", "Success")
            else
                Notify("Işınlan", p.DisplayName .. " şu an ışınlanılamıyor.", "Warning")
            end
        end
        local function DoWatch(p)
            if State.Spectate and State.Target == p then
                SetSpectate(false)
            else
                SetTarget(p)
                if State.Spectate then
                    local h = p.Character and p.Character:FindFirstChildOfClass("Humanoid")
                    if h then Workspace.CurrentCamera.CameraSubject = h end
                else
                    SetSpectate(true)
                end
            end
        end
        local function DoListen(p)
            if State.Listen and State.Target == p then
                SetListen(false)
            elseif State.Listen then
                SetTarget(p)
            else
                SetTarget(p)
                SetListen(true)
            end
        end
        local function ToggleMark(p)
            if UI.Marked[p] then UI.Marked[p] = nil else UI.Marked[p] = true end
            if BuildESP then BuildESP(p) end
            Notify("ESP", UI.Marked[p] and (p.DisplayName .. " işaretlendi (ESP kapalı olsa bile görünür).") or (p.DisplayName .. " işareti kaldırıldı."), "Info")
        end
        local function Copy(text, what)
            if CopyText(text) then
                Notify("Kopyalandı", what .. ": " .. text, "Success")
            else
                Notify("Kopyala", "Panoya kopyalama desteklenmiyor.", "Error")
            end
        end

        dTP.Button.MouseButton1Click:Connect(function() local p = State.Target if p then DoTP(p) end end)
        dWatch.Button.MouseButton1Click:Connect(function() local p = State.Target if p then DoWatch(p) end end)
        dListen.Button.MouseButton1Click:Connect(function() local p = State.Target if p then DoListen(p) end end)
        dMark.Button.MouseButton1Click:Connect(function() local p = State.Target if p then ToggleMark(p) end end)
        dFollow.Button.MouseButton1Click:Connect(function()
            if State.Target then State.Follow = not State.Follow end
        end)
        dCopyAnim.Button.MouseButton1Click:Connect(function()
            if not State.Target then return end
            State.CopyAnim = not State.CopyAnim
            if not State.CopyAnim then StopCopy() end
        end)
        dCopyId.Button.MouseButton1Click:Connect(function() local p = State.Target if p then Copy(tostring(p.UserId), "ID") end end)
        dCopyName.Button.MouseButton1Click:Connect(function() local p = State.Target if p then Copy(p.Name, "İsim") end end)
        dCopyLink.Button.MouseButton1Click:Connect(function()
            local p = State.Target
            if p then Copy("https://www.roblox.com/users/" .. tostring(p.UserId) .. "/profile", "Profil") end
        end)

        local function TeamColorOf(p)
            if p.Team and p.TeamColor then return p.TeamColor.Color end
            return nil
        end
        local function BadgeText(p)
            local b = ""
            if IsFriend(p) then b = b .. '  <font color="' .. Rgb(C.ACCENT) .. '"><b>Arkadaş</b></font>' end
            if p.MembershipType == Enum.MembershipType.Premium then b = b .. '  <font color="' .. Rgb(C.WARN) .. '"><b>Premium</b></font>' end
            if UI.Marked[p] then b = b .. '  <font color="' .. Rgb(C.ACCENT2) .. '"><b>İşaretli</b></font>' end
            return b
        end
        local function DistTo(p, myRoot)
            local r = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
            if r and myRoot then return (r.Position - myRoot.Position).Magnitude end
            return math.huge
        end
        local function HealthFrac(p)
            local h = p.Character and p.Character:FindFirstChildOfClass("Humanoid")
            if h and h.MaxHealth > 0 then return math.clamp(h.Health / h.MaxHealth, 0, 1) end
            return 2
        end

        local function MakeRow(p)
            local isMe = (p == LP)
            local row = New("Frame", { Size = UDim2.new(1, -8, 0, ROW_H), BackgroundColor3 = C.CARD, BorderSizePixel = 0 }, Scroll)
            Round(row, 14)
            local stroke = Stroke(row, C.STROKE, 1.2, 0.55)
            local bar = New("Frame", { Size = UDim2.new(0, 3, 0, 32), Position = UDim2.new(0, 0, 0.5, -16), BackgroundColor3 = C.ACCENT, BackgroundTransparency = 1, BorderSizePixel = 0 }, row)
            Round(bar, 2)

            local av = New("ImageLabel", { Size = UDim2.new(0, 46, 0, 46), Position = UDim2.new(0, 14, 0.5, -23), BackgroundColor3 = C.CHIP, BorderSizePixel = 0 }, row)
            Round(av, 23)
            local ring = Stroke(av, C.ACCENT, 2, 0.45)
            if isMe then
                Grad(ring, "ACCENT", "ACCENT2", 45)
                ring.Transparency = 0
            end
            task.spawn(function()
                local img = GetThumb(p.UserId)
                if av.Parent then av.Image = img end
            end)
            local dot = New("Frame", { Size = UDim2.new(0, 12, 0, 12), Position = UDim2.new(0, 14 + 46 - 13, 0.5, 23 - 12), BackgroundColor3 = C.ACCENT2, BorderSizePixel = 0, ZIndex = 3 }, row)
            Round(dot, 6)
            local dotStroke = Stroke(dot, C.CARD, 2, 0)

            local rightPad = isMe and 76 or 200
            local nm = Label(row, { Position = UDim2.new(0, 74, 0, 11), Size = UDim2.new(1, -(74 + rightPad), 0, 18), Font = Enum.Font.GothamBold, TextSize = 14, RichText = true, Text = Esc(p.DisplayName) })
            local sub = Label(row, { Position = UDim2.new(0, 74, 0, 30), Size = UDim2.new(1, -(74 + rightPad), 0, 14), TextSize = 11, TextColor3 = C.DIM, RichText = true, Text = "@" .. Esc(p.Name) })
            local hpBack = New("Frame", { Position = UDim2.new(0, 74, 0, 51), Size = UDim2.new(1, -(74 + rightPad), 0, 4), BackgroundColor3 = C.PANEL, BorderSizePixel = 0 }, row)
            Round(hpBack, 2)
            local hpFill = New("Frame", { Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = C.ACCENT2, BorderSizePixel = 0 }, hpBack)
            Round(hpFill, 2)

            local entry = {
                P = p, Row = row, Stroke = stroke, Ring = ring, Name = nm, Sub = sub, Av = av, Bar = bar, Dot = dot, DotStroke = dotStroke,
                HpBack = hpBack, HpFill = hpFill, Hover = false,
                Key = string.lower(p.DisplayName .. " " .. p.Name),
            }

            if isMe then
                local pill = New("Frame", { Size = UDim2.new(0, 46, 0, 22), Position = UDim2.new(1, -(12 + 46), 0.5, -11), BackgroundColor3 = C.ACCENT, BorderSizePixel = 0 }, row)
                Round(pill, 11)
                Grad(pill, "ACCENT", "ACCENT2", 0)
                Label(pill, { Size = UDim2.new(1, 0, 1, 0), Text = "SEN", Font = Enum.Font.GothamBold, TextSize = 10, TextColor3 = C.DARK, TextXAlignment = Enum.TextXAlignment.Center })
            else
                local listen = GButton(row, "Dinle", { Size = UDim2.new(0, 52, 0, 28), Position = UDim2.new(1, -(12 + 52), 0.5, -14) }, "pink")
                local watch = GButton(row, "İzle", { Size = UDim2.new(0, 46, 0, 28), Position = UDim2.new(1, -(12 + 52 + 5 + 46), 0.5, -14) }, "blue")
                local tp = GButton(row, "TP", { Size = UDim2.new(0, 36, 0, 28), Position = UDim2.new(1, -(12 + 52 + 5 + 46 + 5 + 36), 0.5, -14) }, "ghost")
                local mark = GButton(row, "ESP", { Size = UDim2.new(0, 30, 0, 28), Position = UDim2.new(1, -(12 + 52 + 5 + 46 + 5 + 36 + 5 + 30), 0.5, -14), TextSize = 10 }, "pink")
                entry.Listen, entry.Watch, entry.TP, entry.Mark = listen, watch, tp, mark
                tp.Button.MouseButton1Click:Connect(function() DoTP(p) end)
                watch.Button.MouseButton1Click:Connect(function() DoWatch(p) end)
                listen.Button.MouseButton1Click:Connect(function() DoListen(p) end)
                mark.Button.MouseButton1Click:Connect(function() ToggleMark(p) end)

                local pick = New("TextButton", { Size = UDim2.new(1, -(rightPad + 4), 1, 0), BackgroundTransparency = 1, Text = "", ZIndex = 0 }, row)
                pick.MouseButton1Click:Connect(function()
                    if State.Target == p then SetTarget(nil) else SetTarget(p) end
                end)
            end

            entry.Paint = function()
                local selected = (State.Target == p)
                local bg = (entry.Hover or selected) and C.HOVER or C.CARD
                Tween(row, 0.14, { BackgroundColor3 = bg })
                Tween(dotStroke, 0.14, { Color = bg })
                if selected then
                    Tween(stroke, 0.14, { Color = C.ACCENT, Transparency = 0.1 })
                elseif entry.Hover then
                    Tween(stroke, 0.14, { Color = C.ACCENT2, Transparency = 0.45 })
                else
                    Tween(stroke, 0.14, { Color = C.STROKE, Transparency = 0.55 })
                end
                local tc = TeamColorOf(p)
                bar.BackgroundColor3 = selected and C.ACCENT or (tc or C.ACCENT)
                Tween(bar, 0.14, { BackgroundTransparency = (selected or tc) and 0 or 1 })
            end
            row.MouseEnter:Connect(function() entry.Hover = true entry.Paint() end)
            row.MouseLeave:Connect(function() entry.Hover = false entry.Paint() end)

            PL.Rows[p] = entry
            return entry
        end

        local function GetHeader(name)
            local h = PL.Headers[name]
            if not h or not h.Parent then
                h = Label(Scroll, { Size = UDim2.new(1, -8, 0, 22), Text = "", Font = Enum.Font.GothamBold, TextSize = 11, TextColor3 = C.DIM, RichText = true })
                Pad(h, 8, 0, 0, 0)
                PL.Headers[name] = h
            end
            return h
        end

        local function ApplySort()
            local myRoot = GetRoot()
            local arr, keys = {}, {}
            for p in pairs(PL.Rows) do
                table.insert(arr, p)
                if PL.Sort == "Mesafe" then keys[p] = DistTo(p, myRoot)
                elseif PL.Sort == "Takım" then keys[p] = p.Team and p.Team.Name or "~"
                elseif PL.Sort == "Can" then keys[p] = HealthFrac(p)
                else keys[p] = 0 end
            end
            table.sort(arr, function(a, b)
                if a == LP then return true end
                if b == LP then return false end
                if keys[a] ~= keys[b] then return keys[a] < keys[b] end
                local na, nb = string.lower(a.DisplayName), string.lower(b.DisplayName)
                if na ~= nb then return na < nb end
                return a.UserId < b.UserId
            end)

            for _, h in pairs(PL.Headers) do h.Visible = false end
            local last
            for i, p in ipairs(arr) do
                PL.Rows[p].Row.LayoutOrder = i * 2
                if PL.Sort == "Takım" then
                    local tn = (p == LP) and "Sen" or (p.Team and p.Team.Name or "Takımsız")
                    if tn ~= last then
                        last = tn
                        local h = GetHeader(tn)
                        local tc = (p ~= LP and TeamColorOf(p)) or C.ACCENT
                        h.Text = '<font color="' .. Rgb(tc) .. '"><b>|</b></font>  ' .. Esc(tn)
                        h.LayoutOrder = i * 2 - 1
                        h.Visible = true
                    end
                end
            end
        end

        local function ApplyFilter()
            local f = string.lower(PL.Filter or "")
            local myRoot = GetRoot()
            local visible = 0
            for p, e in pairs(PL.Rows) do
                local ok = (f == "") or (string.find(e.Key, f, 1, true) ~= nil)
                if ok and p ~= LP then
                    if PL.Mode == "Arkadaş" then ok = IsFriend(p)
                    elseif PL.Mode == "Yakın" then ok = DistTo(p, myRoot) <= NEAR_DIST
                    elseif PL.Mode == "İşaretli" then ok = UI.Marked[p] == true end
                elseif ok and p == LP and PL.Mode ~= "Hepsi" then
                    ok = false
                end
                e.Row.Visible = ok
                if ok then visible += 1 end
            end
            Empty.Visible = (visible == 0)
        end

        RefreshList = function()
            local present = {}
            for _, p in ipairs(Players:GetPlayers()) do present[p] = true end
            for p, e in pairs(PL.Rows) do
                if not present[p] then
                    e.Row:Destroy()
                    PL.Rows[p] = nil
                end
            end
            for _, p in ipairs(Players:GetPlayers()) do
                if not PL.Rows[p] then MakeRow(p) end
            end
            UI.PruneBinds()
            ApplySort()
            HCount.Text = #Players:GetPlayers() .. " oyuncu"
            ApplyFilter()
        end

        Connect(Search:GetPropertyChangedSignal("Text"), function()
            PL.Filter = Search.Text
            ClearBtn.Visible = (Search.Text ~= "")
            ApplyFilter()
        end)

        for _, m in ipairs(MODES) do
            ModeBtns[m].MouseButton1Click:Connect(function()
                PL.Mode = m
                PaintModes(true)
                ApplyFilter()
            end)
        end

        SortBtn.MouseButton1Click:Connect(function()
            local idx = 1
            for i, s in ipairs(SORTS) do if s == PL.Sort then idx = i end end
            PL.Sort = SORTS[(idx % #SORTS) + 1]
            SortBtn.Text = "Sırala: " .. PL.Sort
            ApplySort()
        end)

        local LastTarget, DetailFor = nil, nil
        local function Relayout(animate)
            local hasT = State.Target ~= nil
            local size = UDim2.new(1, -16, 1, -(LIST_Y + FOOTER_H + (hasT and (DETAIL_H + 8) or 0)))
            Detail.Visible = hasT
            if animate then Tween(Scroll, 0.18, { Size = size }) else Scroll.Size = size end
        end

        local function UpdateDetail()
            local p = State.Target
            if not p then return end
            if DetailFor ~= p then
                DetailFor = p
                DImg.Image = ""
                task.spawn(function()
                    local img = GetBust(p.UserId)
                    if DetailFor == p then DImg.Image = img end
                end)
            end
            local ch = p.Character
            local hum = ch and ch:FindFirstChildOfClass("Humanoid")
            local root = ch and ch:FindFirstChild("HumanoidRootPart")
            local myRoot = GetRoot()
            local col = TeamColorOf(p)
            DRing.Color = col or C.ACCENT

            DName.Text = Esc(p.DisplayName) .. BadgeText(p)
            DUser.Text = "@" .. p.Name
            DInfo1.Text = "ID " .. tostring(p.UserId) .. "  •  Hesap yaşı " .. tostring(p.AccountAge) .. " gün"
            local teamTxt = col and ('<font color="' .. Rgb(col) .. '">' .. Esc(p.Team.Name) .. "</font>") or "Takımsız"
            local distTxt = (root and myRoot) and (tostring(math.floor((root.Position - myRoot.Position).Magnitude)) .. " birim") or "uzakta"
            local tool = HeldTool(p)
            DInfo2.Text = teamTxt .. "  •  " .. distTxt .. (tool and ("  •  Eşya: " .. Esc(tool)) or "")

            if hum then
                local frac = math.clamp(hum.Health / math.max(hum.MaxHealth, 1), 0, 1)
                DHpFill.Size = UDim2.new(frac, 0, 1, 0)
                DHpFill.BackgroundColor3 = C.BAD:Lerp(C.ACCENT2, frac)
                DHpText.Text = "Can  " .. tostring(math.floor(hum.Health + 0.5)) .. " / " .. tostring(math.floor(hum.MaxHealth + 0.5))
            else
                DHpFill.Size = UDim2.new(0, 0, 1, 0)
                DHpText.Text = "Can bilgisi yok"
            end

            dWatch.SetActive(State.Spectate and State.Target == p)
            dListen.SetActive(State.Listen and State.Target == p)
            dFollow.SetActive(State.Follow)
            dCopyAnim.SetActive(State.CopyAnim)
            dMark.SetActive(UI.Marked[p] == true)
        end

        UpdateListState = function()
            local myRoot = GetRoot()
            local friends, marked, near = 0, 0, 0
            for p, e in pairs(PL.Rows) do
                local ch = p.Character
                local troot = ch and ch:FindFirstChild("HumanoidRootPart")
                local hum = ch and ch:FindFirstChildOfClass("Humanoid")
                local isMe = (p == LP)
                local dead = hum ~= nil and hum.Health <= 0

                if IsFriend(p) then friends += 1 end
                if UI.Marked[p] then marked += 1 end
                if not isMe and DistTo(p, myRoot) <= NEAR_DIST then near += 1 end

                e.Name.Text = Esc(p.DisplayName) .. BadgeText(p)
                e.Name.TextTransparency = dead and 0.45 or 0
                e.Av.ImageTransparency = dead and 0.5 or 0
                e.Dot.BackgroundColor3 = dead and C.BAD or C.ACCENT2

                local parts = { "@" .. Esc(p.Name) }
                if dead then
                    table.insert(parts, "ölü")
                elseif not isMe then
                    if myRoot and troot then
                        table.insert(parts, tostring(math.floor((troot.Position - myRoot.Position).Magnitude)) .. " birim")
                    else
                        table.insert(parts, "uzakta")
                    end
                end
                local tc = TeamColorOf(p)
                if tc then
                    table.insert(parts, '<font color="' .. Rgb(tc) .. '">' .. Esc(p.Team.Name) .. "</font>")
                end
                e.Sub.Text = table.concat(parts, "  •  ")

                if not isMe then
                    e.Ring.Color = tc or C.ACCENT
                    e.Ring.Transparency = tc and 0 or 0.45
                end
                if hum then
                    local frac = math.clamp(hum.Health / math.max(hum.MaxHealth, 1), 0, 1)
                    e.HpFill.Size = UDim2.new(frac, 0, 1, 0)
                    e.HpFill.BackgroundColor3 = C.BAD:Lerp(C.ACCENT2, frac)
                else
                    e.HpFill.Size = UDim2.new(0, 0, 1, 0)
                end

                if e.Watch then e.Watch.SetActive(State.Spectate and State.Target == p) end
                if e.Listen then e.Listen.SetActive(State.Listen and State.Target == p) end
                if e.Mark then e.Mark.SetActive(UI.Marked[p] == true) end
                if e.Paint then e.Paint() end
            end

            if PL.Sort ~= "Ad" then ApplySort() end
            if PL.Mode ~= "Hepsi" then ApplyFilter() end

            ModeBtns["Arkadaş"].Text = "Arkadaş" .. (friends > 0 and ("  " .. friends) or "")
            ModeBtns["Yakın"].Text = "Yakın" .. (near > 0 and ("  " .. near) or "")
            ModeBtns["İşaretli"].Text = "İşaretli" .. (marked > 0 and ("  " .. marked) or "")

            if LastTarget ~= State.Target then
                LastTarget = State.Target
                DetailFor = nil
                Relayout(true)
            end
            UpdateDetail()
            HGame.Text = GameName
            HCount.Text = #Players:GetPlayers() .. " oyuncu"
            Hint.Text = friends .. " arkadaş  •  " .. marked .. " işaretli  •  P: gizle/göster"
        end

        Relayout(false)

        PlayersTab:CreateSection("Oyuncu listesi paneli")

        PlayersTab:CreateToggle({
            Name = "Oyuncu listesini göster",
            Desc = "Arama, filtre, sıralama, detay kartı ve TP / İzle / Dinle (sürüklenebilir, boyutlandırılabilir)",
            CurrentValue = true,
            Flag = "PlayerListToggle",
            Callback = function(Value) PL.Gui.Enabled = Value end,
        })

        PlayersTab:CreateKeybind({
            Name = "Oyuncu listesi tuşu",
            CurrentKeybind = "P",
            Flag = "PlayerListKey",
            Callback = function() PL.Gui.Enabled = not PL.Gui.Enabled end,
        })

        PlayersTab:CreateButton({
            Name = "Listeyi varsayılan konuma getir",
            Icon = "rotate-ccw",
            Callback = function()
                Main.Position = DEFAULT_POS
                Main.Size = DEFAULT_SIZE
                Minimized = false
                Body.Visible = true
                GripBtn.Visible = true
                GlowBot.Visible = true
            end,
        })

        PlayersTab:CreateButton({
            Name = "Tüm işaretleri kaldır",
            Icon = "square",
            Callback = function()
                local list = {}
                for p in pairs(UI.Marked) do table.insert(list, p) end
                UI.Marked = {}
                for _, p in ipairs(list) do if BuildESP then BuildESP(p) end end
            end,
        })
    end

    BuildPlayerList()
end

local HasDrawing = (typeof(Drawing) == "table" or typeof(Drawing) == "userdata") and Drawing.new ~= nil

do
    local C = UI.C
    local New, Round, Stroke, Label = UI.New, UI.Round, UI.Stroke, UI.Label
    local Esc, Rgb = UI.Esc, UI.Rgb
    local MARK_COLOR = Color3.fromRGB(255, 205, 80)
    local WHITE = Color3.new(1, 1, 1)

    ESP = {
        Enabled = false,
        Style = "Kart",
        Box = "Köşeli",
        BoxFill = 0.88,
        Skeleton = false,
        Avatars = true, Names = true, Username = true, Distance = true,
        Health = true, SideHp = true, Tool = true, TeamTag = true, Badges = true,
        Highlight = false, Fill = 0.7,
        Tracers = false, TracerFrom = "Alt", TeamCheck = false, TeamColor = false, TargetColor = true,
        Color = ACCENT, MaxDist = 2000, Scale = 1, CardAlpha = 0, DistScale = true,
        Objects = {},
    }

    local Folder = Instance.new("Folder")
    Folder.Name = "HexionESP"
    Folder.Parent = GuiParent()
    ESP.Folder = Folder

    local Styles = {
        ["Kart"] = { W = 236, H = 62, R = 12, Alpha = 0.06, Big = true, Av = 40, Chip = 46,
            Top = Color3.fromRGB(42, 38, 56), Bot = Color3.fromRGB(16, 15, 24) },
        ["Cam"] = { W = 236, H = 62, R = 16, Alpha = 0.38, Big = true, Av = 40, Chip = 46,
            Top = Color3.fromRGB(96, 90, 120), Bot = Color3.fromRGB(28, 26, 40) },
        ["Rozet"] = { W = 180, H = 30, R = 15, Alpha = 0.10, Av = 22, Chip = 44,
            Top = Color3.fromRGB(40, 36, 52), Bot = Color3.fromRGB(16, 15, 24) },
        ["Kompakt"] = { W = 154, H = 26, R = 8, Alpha = 0.10, Av = 18, Chip = 40,
            Top = Color3.fromRGB(40, 36, 52), Bot = Color3.fromRGB(16, 15, 24) },
        ["Minimal"] = { W = 180, H = 20, R = 0, Alpha = 1, Mini = true, Av = 0, Chip = 0,
            Top = WHITE, Bot = WHITE },
    }

    local R15 = {
        { "Head", "UpperTorso" }, { "UpperTorso", "LowerTorso" },
        { "UpperTorso", "LeftUpperArm" }, { "LeftUpperArm", "LeftLowerArm" }, { "LeftLowerArm", "LeftHand" },
        { "UpperTorso", "RightUpperArm" }, { "RightUpperArm", "RightLowerArm" }, { "RightLowerArm", "RightHand" },
        { "LowerTorso", "LeftUpperLeg" }, { "LeftUpperLeg", "LeftLowerLeg" }, { "LeftLowerLeg", "LeftFoot" },
        { "LowerTorso", "RightUpperLeg" }, { "RightUpperLeg", "RightLowerLeg" }, { "RightLowerLeg", "RightFoot" },
    }
    local R6 = {
        { "Head", "Torso" }, { "Torso", "Left Arm" }, { "Torso", "Right Arm" },
        { "Torso", "Left Leg" }, { "Torso", "Right Leg" },
    }
    local FeetNames = { "LeftFoot", "RightFoot", "Left Leg", "Right Leg" }

    local function ColorFor(p)
        if UI.Marked[p] then return MARK_COLOR end
        if ESP.TargetColor and State.Target == p then return C.ACCENT2 end
        if ESP.TeamColor and p.Team and p.TeamColor then return p.TeamColor.Color end
        return ESP.Color
    end

    local function NameText(p)
        local t = Esc(p.DisplayName)
        if ESP.Badges then
            if State.Target == p then t = t .. '  <font color="' .. Rgb(C.ACCENT2) .. '"><b>Hedef</b></font>' end
            if UI.IsFriend(p) then t = t .. '  <font color="' .. Rgb(C.GOOD) .. '"><b>Arkadaş</b></font>' end
            if p.MembershipType == Enum.MembershipType.Premium then t = t .. '  <font color="' .. Rgb(C.WARN) .. '"><b>Premium</b></font>' end
            if UI.Marked[p] then t = t .. '  <font color="rgb(255,205,80)"><b>İşaretli</b></font>' end
        end
        return t
    end

    local function SubText(p, o)
        local parts = {}
        if ESP.Username then table.insert(parts, "@" .. Esc(p.Name)) end
        if ESP.TeamTag and p.Team and p.TeamColor then
            table.insert(parts, '<font color="' .. Rgb(p.TeamColor.Color) .. '">' .. Esc(p.Team.Name) .. "</font>")
        end
        if ESP.Tool then
            local t = o.Char and o.Char:FindFirstChildOfClass("Tool")
            if t then table.insert(parts, "Eşya: " .. Esc(t.Name)) end
        end
        return table.concat(parts, "  ·  ")
    end

    local function Measure(o)
        local ch, root = o.Char, o.Root
        local head = ch:FindFirstChild("Head")
        local top, bottom
        if head and head:IsA("BasePart") then top = head.Position.Y + head.Size.Y / 2 end
        for _, n in ipairs(FeetNames) do
            local part = ch:FindFirstChild(n)
            if part and part:IsA("BasePart") then
                local y = part.Position.Y - part.Size.Y / 2
                if not bottom or y < bottom then bottom = y end
            end
        end
        top = top or (root.Position.Y + 2.7)
        bottom = bottom or (root.Position.Y - 3)
        local h = math.clamp(top - bottom + 0.25, 2.5, 14)
        o.BoxH = h
        o.BoxW = math.clamp(h * 0.52, 1.6, 7)
        o.CY = (top + bottom) / 2 - root.Position.Y
    end

    local function Place(o)
        o.BoxBB.Size = UDim2.new(o.BoxW, 0, o.BoxH, 0)
        o.BoxBB.StudsOffsetWorldSpace = Vector3.new(0, o.CY, 0)
        o.TopBB.StudsOffsetWorldSpace = Vector3.new(0, o.CY + o.BoxH / 2 + 0.35, 0)
        o.BotBB.StudsOffsetWorldSpace = Vector3.new(0, o.CY - o.BoxH / 2 - 0.35, 0)
    end

    local function SetShown(o)
        local s = o.Show
        local box = ESP.Box
        local mini = ESP.Style == "Minimal"
        o.TopBB.Enabled = s
        o.BotBB.Enabled = s and mini and (ESP.Distance or ESP.Health)
        o.BoxBB.Enabled = s and (box ~= "Kapalı" or (ESP.Health and ESP.SideHp))
        o.Highlight.Enabled = s and ESP.Highlight
        o.Edge.Enabled = (box == "Tam")
        o.Shadow.Visible = (box == "Tam")
        for _, f in ipairs(o.CornerParts) do f.Visible = (box == "Köşeli") end
        o.BoxRoot.BackgroundTransparency = (box ~= "Kapalı") and ESP.BoxFill or 1
        o.HpBack.Visible = ESP.Health and ESP.SideHp
        o.Glow.Visible = (box == "Tam")
        o.BoxCorner.CornerRadius = UDim.new(0, (box == "Tam") and 6 or 0)
        o.GlowCorner.CornerRadius = UDim.new(0, (box == "Tam") and 9 or 0)
    end

    local function Layout(o)
        local st = ESP.Style
        local S = Styles[st] or Styles["Kart"]
        local mini = S.Mini == true
        local big = S.Big == true
        local av = ESP.Avatars and not mini
        local chipOn = ESP.Distance and not mini
        local hpOn = ESP.Health and not mini

        o.TopBB.Size = UDim2.new(0, S.W, 0, S.H * 2)
        o.TopCard.Size = UDim2.new(1, 0, 0, S.H)
        o.TopCorner.CornerRadius = UDim.new(0, S.R)
        o.TopCard.BackgroundTransparency = mini and 1 or math.clamp(S.Alpha + ESP.CardAlpha, 0, 0.95)
        o.TopStroke.Enabled = not mini
        o.TopStroke.Transparency = (st == "Cam") and 0.4 or 0.2
        o.CardGrad.Enabled = not mini
        o.CardGrad.Color = ColorSequence.new(S.Top, S.Bot)
        o.Bar.Visible = (st == "Kart")

        o.Img.Visible = av
        o.Chip.Visible = chipOn
        o.CHpTrack.Visible = hpOn
        o.CHpText.Visible = hpOn and big
        o.Sub.Visible = big
        o.Name.Visible = ESP.Names

        if big then
            local tx = av and 58 or 14
            o.Img.Size = UDim2.new(0, S.Av, 0, S.Av)
            o.Img.Position = UDim2.new(0, 10, 0.5, -S.Av / 2)
            o.Chip.AnchorPoint = Vector2.new(1, 0)
            o.Chip.Size = UDim2.new(0, S.Chip, 0, 16)
            o.Chip.Position = UDim2.new(1, -10, 0, 8)
            o.Name.Position = UDim2.new(0, tx, 0, 8)
            o.Name.Size = UDim2.new(1, -(tx + (chipOn and (S.Chip + 16) or 10)), 0, 17)
            o.Name.TextSize = 14
            o.Name.TextXAlignment = Enum.TextXAlignment.Left
            o.Name.TextStrokeTransparency = 1
            o.Sub.Position = UDim2.new(0, tx, 0, 26)
            o.Sub.Size = UDim2.new(1, -(tx + 10), 0, 13)
            o.CHpTrack.Position = UDim2.new(0, tx, 0, 46)
            o.CHpTrack.Size = UDim2.new(1, -(tx + 68), 0, 6)
            o.CHpText.AnchorPoint = Vector2.new(1, 0)
            o.CHpText.Position = UDim2.new(1, -10, 0, 41)
            o.CHpText.Size = UDim2.new(0, 56, 0, 14)
        elseif mini then
            o.Name.Position = UDim2.new(0, 0, 0, 0)
            o.Name.Size = UDim2.new(1, 0, 1, 0)
            o.Name.TextSize = 14
            o.Name.TextXAlignment = Enum.TextXAlignment.Center
            o.Name.TextStrokeTransparency = 0.2
        else
            local tx = av and (S.Av + 10) or 12
            o.Img.Size = UDim2.new(0, S.Av, 0, S.Av)
            o.Img.Position = UDim2.new(0, 4, 0.5, -S.Av / 2)
            o.Chip.AnchorPoint = Vector2.new(1, 0.5)
            o.Chip.Size = UDim2.new(0, S.Chip, 0, S.H - 10)
            o.Chip.Position = UDim2.new(1, -5, 0.5, 0)
            o.Name.Position = UDim2.new(0, tx, 0, 0)
            o.Name.Size = UDim2.new(1, -(tx + (chipOn and (S.Chip + 12) or 8)), 1, hpOn and -3 or 0)
            o.Name.TextSize = 13
            o.Name.TextXAlignment = Enum.TextXAlignment.Left
            o.Name.TextStrokeTransparency = 1
            o.CHpTrack.Position = UDim2.new(0, math.floor(S.R * 0.9), 1, -5)
            o.CHpTrack.Size = UDim2.new(1, -math.floor(S.R * 1.8), 0, 2)
        end

        Place(o)
        SetShown(o)
    end

    local function ApplyColors(o, col)
        o.Col = col
        local lite = col:Lerp(WHITE, 0.55)
        o.Highlight.FillColor = col
        o.Highlight.OutlineColor = lite
        o.BoxRoot.BackgroundColor3 = col
        o.Edge.Color = col
        o.GlowStroke.Color = col
        for _, f in ipairs(o.CornerParts) do f.BackgroundColor3 = col end
        o.TopStroke.Color = col
        o.ChipStroke.Color = col
        o.BarGrad.Color = ColorSequence.new(col, lite)
        o.ImgStroke.Color = col
        if o.Line then o.Line.Color = col end
    end

    local function RemoveBones(o)
        if o.Bones then
            for _, b in ipairs(o.Bones) do pcall(function() b[3]:Remove() end) end
            o.Bones = nil
        end
    end

    ClearESP = function(p)
        local o = ESP.Objects[p]
        if o then
            for _, inst in pairs(o.Instances) do
                pcall(function() inst:Destroy() end)
            end
            if o.Line then pcall(function() o.Line:Remove() end) end
            RemoveBones(o)
            ESP.Objects[p] = nil
        end
    end

    local function Corner(parent, col, left, top)
        local fx = left and 0 or 1
        local fy = top and 0 or 1
        local hz = New("Frame", {
            Size = UDim2.new(0.3, 0, 0, 2), AnchorPoint = Vector2.new(fx, fy), Position = UDim2.new(fx, 0, fy, 0),
            BackgroundColor3 = col, BorderSizePixel = 0,
        }, parent)
        local vt = New("Frame", {
            Size = UDim2.new(0, 2, 0.24, 0), AnchorPoint = Vector2.new(fx, fy), Position = UDim2.new(fx, 0, fy, 0),
            BackgroundColor3 = col, BorderSizePixel = 0,
        }, parent)
        return hz, vt
    end

    BuildESP = function(p)
        ClearESP(p)
        if p == LP or not (ESP.Enabled or UI.Marked[p]) then return end
        local ch = p.Character
        local head = ch and ch:FindFirstChild("Head")
        local root = ch and ch:FindFirstChild("HumanoidRootPart")
        if not head or not root then return end

        local col = ColorFor(p)
        local lite = col:Lerp(WHITE, 0.55)
        local o = {
            Instances = {}, Player = p, Show = true, Char = ch, Root = root, Col = col,
            Hum = ch:FindFirstChildOfClass("Humanoid"), BoxW = 3, BoxH = 5.5, CY = 0,
        }

        local hl = Instance.new("Highlight")
        hl.FillColor = col
        hl.OutlineColor = lite
        hl.FillTransparency = ESP.Fill
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hl.Adornee = ch
        hl.Parent = Folder
        table.insert(o.Instances, hl)
        o.Highlight = hl

        local function MakeBB(size)
            local bb = Instance.new("BillboardGui")
            bb.Size = size
            bb.AlwaysOnTop = true
            bb.LightInfluence = 0
            bb.ResetOnSpawn = false
            bb.Active = false
            bb.Adornee = root
            bb.MaxDistance = math.huge
            bb.Parent = Folder
            table.insert(o.Instances, bb)
            return bb
        end

        o.BoxBB = MakeBB(UDim2.new(3, 0, 5.5, 0))
        o.BoxRoot = New("Frame", { Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = col, BackgroundTransparency = 0.88, BorderSizePixel = 0 }, o.BoxBB)
        o.Shadow = New("Frame", { Size = UDim2.new(1, 2, 1, 2), Position = UDim2.new(0, -1, 0, -1), BackgroundTransparency = 1, BorderSizePixel = 0, Visible = false }, o.BoxRoot)
        Stroke(o.Shadow, Color3.new(0, 0, 0), 3.5, 0.45)
        o.Edge = Stroke(o.BoxRoot, col, 1.6, 0)
        o.BoxCorner = Instance.new("UICorner")
        o.BoxCorner.CornerRadius = UDim.new(0, 0)
        o.BoxCorner.Parent = o.BoxRoot
        do
            local fg = Instance.new("UIGradient")
            fg.Rotation = 90
            fg.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0.7) })
            fg.Parent = o.BoxRoot
        end
        o.Glow = New("Frame", { Size = UDim2.new(1, 8, 1, 8), Position = UDim2.new(0, -4, 0, -4), BackgroundTransparency = 1, BorderSizePixel = 0, Visible = false }, o.BoxRoot)
        o.GlowStroke = Stroke(o.Glow, col, 5, 0.8)
        o.GlowCorner = Instance.new("UICorner")
        o.GlowCorner.CornerRadius = UDim.new(0, 0)
        o.GlowCorner.Parent = o.Glow
        o.CornerParts = {}
        for _, cfg in ipairs({ { true, true }, { false, true }, { true, false }, { false, false } }) do
            local hz, vt = Corner(o.BoxRoot, col, cfg[1], cfg[2])
            table.insert(o.CornerParts, hz)
            table.insert(o.CornerParts, vt)
        end
        o.HpBack = New("Frame", { Size = UDim2.new(0, 4, 1, 0), Position = UDim2.new(0, -9, 0, 0), BackgroundColor3 = Color3.fromRGB(12, 12, 16), BorderSizePixel = 0 }, o.BoxRoot)
        Stroke(o.HpBack, Color3.new(0, 0, 0), 1, 0.3)
        o.HpFill = New("Frame", { AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 0, 1, 0), Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = C.GOOD, BorderSizePixel = 0 }, o.HpBack)

        o.TopBB = MakeBB(UDim2.new(0, 236, 0, 124))
        o.TopScale = Instance.new("UIScale")
        o.TopScale.Parent = o.TopBB
        o.TopCard = New("Frame", { AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(1, 0, 0, 62), BackgroundColor3 = WHITE, BorderSizePixel = 0 }, o.TopBB)
        o.TopCorner = Round(o.TopCard, 12)
        o.CardGrad = New("UIGradient", { Rotation = 90 }, o.TopCard)
        o.TopStroke = Stroke(o.TopCard, col, 1.4, 0.2)

        o.Bar = New("Frame", { Position = UDim2.new(0, 14, 0, 0), Size = UDim2.new(1, -28, 0, 2), BackgroundColor3 = WHITE, BorderSizePixel = 0, Visible = false }, o.TopCard)
        Round(o.Bar, 2)
        o.BarGrad = New("UIGradient", { Color = ColorSequence.new(col, lite) }, o.Bar)

        o.Img = New("ImageLabel", { BackgroundColor3 = Color3.fromRGB(30, 30, 38), BorderSizePixel = 0 }, o.TopCard)
        o.ImgCorner = Round(o.Img, 8)
        o.ImgCorner.CornerRadius = UDim.new(1, 0)
        o.ImgStroke = Stroke(o.Img, col, 2, 0)
        task.spawn(function()
            local image = GetThumb(p.UserId)
            if o.Img and o.Img.Parent then o.Img.Image = image end
        end)

        o.Name = Label(o.TopCard, { Font = Enum.Font.GothamBold, TextColor3 = WHITE, RichText = true, Text = NameText(p), TextStrokeColor3 = Color3.new(0, 0, 0) })
        o.NameStr = NameText(p)
        o.Sub = Label(o.TopCard, { TextSize = 11, TextColor3 = Color3.fromRGB(176, 176, 196), RichText = true, Text = "" })

        o.Chip = New("Frame", { BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 0.45, BorderSizePixel = 0 }, o.TopCard)
        Round(o.Chip, 8)
        o.ChipStroke = Stroke(o.Chip, col, 1, 0.55)
        o.ChipText = Label(o.Chip, { Size = UDim2.new(1, 0, 1, 0), Font = Enum.Font.GothamBold, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Center, TextColor3 = WHITE, Text = "" })

        o.CHpTrack = New("Frame", { BackgroundColor3 = Color3.fromRGB(8, 8, 12), BackgroundTransparency = 0.25, BorderSizePixel = 0 }, o.TopCard)
        Round(o.CHpTrack, 6).CornerRadius = UDim.new(1, 0)
        o.CHpFill = New("Frame", { Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = C.GOOD, BorderSizePixel = 0 }, o.CHpTrack)
        Round(o.CHpFill, 6).CornerRadius = UDim.new(1, 0)
        New("UIGradient", { Color = ColorSequence.new(WHITE, Color3.fromRGB(185, 185, 185)), Rotation = 90 }, o.CHpFill)
        o.CHpText = Label(o.TopCard, { Font = Enum.Font.GothamBold, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Right, TextColor3 = C.GOOD, Text = "" })

        o.BotBB = MakeBB(UDim2.new(0, 160, 0, 40))
        o.BotScale = Instance.new("UIScale")
        o.BotScale.Parent = o.BotBB
        o.BotCard = New("Frame", { AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(1, 0, 0, 20), BackgroundTransparency = 1, BorderSizePixel = 0 }, o.BotBB)
        o.Bot = Label(o.BotCard, { Size = UDim2.new(1, 0, 1, 0), TextSize = 11, RichText = true, TextXAlignment = Enum.TextXAlignment.Center, TextColor3 = Color3.fromRGB(230, 230, 240), Text = "", TextStrokeColor3 = Color3.new(0, 0, 0), TextStrokeTransparency = 0.2 })

        if HasDrawing then
            local ok, line = pcall(function()
                local l = Drawing.new("Line")
                l.Thickness = 1.5
                l.Color = col
                l.Transparency = 1
                l.Visible = false
                return l
            end)
            if ok then o.Line = line end
        end

        Measure(o)
        o.Sub.Text = SubText(p, o)
        ESP.Objects[p] = o
        Layout(o)
    end

    RebuildESP = function()
        for _, p in ipairs(Players:GetPlayers()) do
            if ESP.Enabled or UI.Marked[p] then BuildESP(p) else ClearESP(p) end
        end
    end

    ApplyESPStyle = function()
        for p, o in pairs(ESP.Objects) do
            ApplyColors(o, ColorFor(p))
            o.Highlight.FillTransparency = ESP.Fill
            o.NameStr = NameText(p)
            o.Name.Text = o.NameStr
            o.Sub.Text = SubText(p, o)
            Layout(o)
        end
    end

    ESP.Update = function(p, o, myRoot)
        local d = (o.Root.Position - myRoot.Position).Magnitude
        local marked = UI.Marked[p] == true
        local sameTeam = ESP.TeamCheck and p.Team ~= nil and p.Team == LP.Team
        if marked then
            o.Show = true
        else
            o.Show = ESP.Enabled and d <= ESP.MaxDist and not sameTeam
        end
        Measure(o)
        Place(o)
        SetShown(o)
        if not o.Show then return end

        local col = ColorFor(p)
        if col ~= o.Col then ApplyColors(o, col) end

        local k = ESP.Scale
        if ESP.DistScale then
            k = k * (1 - 0.3 * math.clamp(d / math.max(ESP.MaxDist, 1), 0, 1))
        end
        o.TopScale.Scale = k
        o.BotScale.Scale = k

        local hum = o.Hum
        local frac, hp, maxH = 1, 0, 100
        if hum then
            maxH = math.max(hum.MaxHealth, 1)
            hp = hum.Health
            frac = math.clamp(hp / maxH, 0, 1)
        end
        local hpCol = C.BAD:Lerp(C.GOOD, frac)

        o.HpFill.Size = UDim2.new(1, 0, frac, 0)
        o.HpFill.BackgroundColor3 = hpCol
        o.CHpFill.Size = UDim2.new(frac, 0, 1, 0)
        o.CHpFill.BackgroundColor3 = hpCol
        o.CHpText.TextColor3 = hpCol
        o.CHpText.Text = hum and (tostring(math.floor(hp)) .. "/" .. tostring(math.floor(maxH))) or ""
        o.ImgStroke.Color = (ESP.Health and hum) and hpCol or col

        o.ChipText.Text = tostring(math.floor(d)) .. "m"

        local nt = NameText(p)
        if o.NameStr ~= nt then
            o.NameStr = nt
            o.Name.Text = nt
        end
        if Styles[ESP.Style] and Styles[ESP.Style].Big then
            local s = SubText(p, o)
            if o.Sub.Text ~= s then o.Sub.Text = s end
        end

        if ESP.Style == "Minimal" then
            local parts = {}
            if ESP.Distance then table.insert(parts, tostring(math.floor(d)) .. "m") end
            if ESP.Health and hum then
                table.insert(parts, '<font color="' .. Rgb(hpCol) .. '">' .. tostring(math.floor(hp)) .. " / " .. tostring(math.floor(maxH)) .. "</font>")
            end
            o.Bot.Text = table.concat(parts, "  ·  ")
        end
    end

    ESP.Hide = function(o)
        if o.Line then o.Line.Visible = false end
        if o.Bones then
            for _, b in ipairs(o.Bones) do b[3].Visible = false end
        end
    end

    ESP.Frame = function(o, cam, vp)
        if o.Line then
            if ESP.Tracers and o.Show then
                local pos, onScreen = cam:WorldToViewportPoint(o.Root.Position)
                if onScreen and pos.Z > 0 then
                    local from
                    local mode = ESP.TracerFrom
                    if mode == "Orta" then
                        from = Vector2.new(vp.X / 2, vp.Y / 2)
                    elseif mode == "Üst" then
                        from = Vector2.new(vp.X / 2, 0)
                    elseif mode == "Fare" then
                        from = UserInputService:GetMouseLocation()
                    else
                        from = Vector2.new(vp.X / 2, vp.Y)
                    end
                    o.Line.From = from
                    o.Line.To = Vector2.new(pos.X, pos.Y)
                    o.Line.Color = o.Col
                    o.Line.Visible = true
                else
                    o.Line.Visible = false
                end
            else
                o.Line.Visible = false
            end
        end

        if not HasDrawing then return end
        if ESP.Skeleton and o.Show then
            if not o.Bones then
                local def = o.Char:FindFirstChild("UpperTorso") and R15 or R6
                o.Bones = {}
                for _, pr in ipairs(def) do
                    local ok, ln = pcall(function()
                        local l = Drawing.new("Line")
                        l.Thickness = 1.3
                        l.Color = o.Col
                        l.Transparency = 1
                        l.Visible = false
                        return l
                    end)
                    if ok then table.insert(o.Bones, { pr[1], pr[2], ln }) end
                end
            end
            for _, b in ipairs(o.Bones) do
                local pa, pb = o.Char:FindFirstChild(b[1]), o.Char:FindFirstChild(b[2])
                local ln = b[3]
                if pa and pb then
                    local a, aOn = cam:WorldToViewportPoint(pa.Position)
                    local c2, bOn = cam:WorldToViewportPoint(pb.Position)
                    if aOn and bOn and a.Z > 0 and c2.Z > 0 then
                        ln.From = Vector2.new(a.X, a.Y)
                        ln.To = Vector2.new(c2.X, c2.Y)
                        ln.Color = o.Col
                        ln.Visible = true
                    else
                        ln.Visible = false
                    end
                else
                    ln.Visible = false
                end
            end
        elseif o.Bones then
            for _, b in ipairs(o.Bones) do b[3].Visible = false end
        end
    end
end

local function ESPPick(Option)
    if type(Option) == "table" then Option = Option[1] end
    return Option
end

Visuals:CreateSection("Genel")

Visuals:CreateToggle({
    Name = "ESP'yi aç",
    Desc = "Avatarlı kart, isim, can, mesafe ve vurgu",
    CurrentValue = false,
    Flag = "ESP",
    Callback = function(Value)
        ESP.Enabled = Value
        RebuildESP()
    end,
})

Visuals:CreateSlider({
    Name = "Maksimum mesafe",
    Range = { 100, 5000 },
    Increment = 50,
    Suffix = " birim",
    CurrentValue = 2000,
    Flag = "ESPMaxDist",
    Callback = function(Value) ESP.MaxDist = Value end,
})

Visuals:CreateToggle({
    Name = "Uzaktakileri küçült",
    Desc = "Kartlar mesafeyle birlikte küçülür; kapatırsan hep aynı boyda kalır",
    CurrentValue = true,
    Flag = "ESPDistScale",
    Callback = function(Value) ESP.DistScale = Value end,
})

Visuals:CreateSection("Kart tasarımı")

Visuals:CreateDropdown({
    Name = "Kart stili",
    Desc = "Kart: tam bilgi · Cam: yarı saydam · Rozet: hap şekli · Kompakt: küçük · Minimal: yalnızca yazı",
    Options = { "Kart", "Cam", "Rozet", "Kompakt", "Minimal" },
    CurrentOption = "Kart",
    Flag = "ESPStyle",
    Callback = function(Option)
        ESP.Style = ESPPick(Option) or "Kart"
        ApplyESPStyle()
    end,
})

Visuals:CreateSlider({
    Name = "Kart boyutu",
    Range = { 0.6, 1.6 },
    Increment = 0.05,
    Suffix = "x",
    CurrentValue = 1,
    Flag = "ESPScale",
    Callback = function(Value) ESP.Scale = Value ApplyESPStyle() end,
})

Visuals:CreateSlider({
    Name = "Ek şeffaflık",
    Desc = "Kart arka planını daha saydam yapar",
    Range = { 0, 0.6 },
    Increment = 0.02,
    CurrentValue = 0,
    Flag = "ESPCardAlpha",
    Callback = function(Value) ESP.CardAlpha = Value ApplyESPStyle() end,
})

Visuals:CreateSection("Kart içeriği")

Visuals:CreateToggle({ Name = "Profil resimleri", Desc = "Halka rengi canına göre değişir", CurrentValue = true, Flag = "ESPAvatars",
    Callback = function(Value) ESP.Avatars = Value ApplyESPStyle() end })
Visuals:CreateToggle({ Name = "Görünen isim", CurrentValue = true, Flag = "ESPNames",
    Callback = function(Value) ESP.Names = Value ApplyESPStyle() end })
Visuals:CreateToggle({ Name = "Kullanıcı adı (@)", CurrentValue = true, Flag = "ESPUsername",
    Callback = function(Value) ESP.Username = Value ApplyESPStyle() end })
Visuals:CreateToggle({ Name = "Mesafe etiketi", CurrentValue = true, Flag = "ESPDistance",
    Callback = function(Value) ESP.Distance = Value ApplyESPStyle() end })
Visuals:CreateToggle({ Name = "Can barı ve değeri", CurrentValue = true, Flag = "ESPHealth",
    Callback = function(Value) ESP.Health = Value ApplyESPStyle() end })
Visuals:CreateToggle({ Name = "Elindeki eşya", CurrentValue = true, Flag = "ESPTool",
    Callback = function(Value) ESP.Tool = Value ApplyESPStyle() end })
Visuals:CreateToggle({ Name = "Takım etiketi", CurrentValue = true, Flag = "ESPTeamTag",
    Callback = function(Value) ESP.TeamTag = Value ApplyESPStyle() end })
Visuals:CreateToggle({ Name = "Rozetler (hedef / arkadaş / premium)", CurrentValue = true, Flag = "ESPBadges",
    Callback = function(Value) ESP.Badges = Value ApplyESPStyle() end })

Visuals:CreateSection("Kutu")

Visuals:CreateDropdown({
    Name = "Kutu türü",
    Options = { "Köşeli", "Tam", "Kapalı" },
    CurrentOption = "Köşeli",
    Flag = "ESPBox",
    Callback = function(Option)
        ESP.Box = ESPPick(Option) or "Köşeli"
        ApplyESPStyle()
    end,
})

Visuals:CreateSlider({
    Name = "Kutu dolgusu",
    Desc = "1 = dolgu yok",
    Range = { 0.5, 1 },
    Increment = 0.01,
    CurrentValue = 0.88,
    Flag = "ESPBoxFill",
    Callback = function(Value) ESP.BoxFill = Value ApplyESPStyle() end,
})

Visuals:CreateToggle({
    Name = "Kenar can çubuğu",
    Desc = "Kutunun yanında dikey can çubuğu",
    CurrentValue = true,
    Flag = "ESPSideHp",
    Callback = function(Value) ESP.SideHp = Value ApplyESPStyle() end,
})

Visuals:CreateSection("Vücut ve çizgiler")

Visuals:CreateToggle({
    Name = "İskelet",
    Desc = HasDrawing and "Kemik çizgilerini çizer" or "Executor'ında Drawing kütüphanesi yok",
    CurrentValue = false,
    Flag = "ESPSkeleton",
    Callback = function(Value) ESP.Skeleton = Value end,
})

Visuals:CreateToggle({
    Name = "Tracer çizgileri",
    Desc = HasDrawing and "Seçtiğin noktadan her oyuncuya çizgi çeker" or "Executor'ında Drawing kütüphanesi yok",
    CurrentValue = false,
    Flag = "ESPTracers",
    Callback = function(Value)
        ESP.Tracers = Value
        if not Value then
            for _, o in pairs(ESP.Objects) do
                if o.Line then o.Line.Visible = false end
            end
        end
    end,
})

Visuals:CreateDropdown({
    Name = "Tracer başlangıcı",
    Options = { "Alt", "Orta", "Üst", "Fare" },
    CurrentOption = "Alt",
    Flag = "ESPTracerFrom",
    Callback = function(Option) ESP.TracerFrom = ESPPick(Option) or "Alt" end,
})

Visuals:CreateToggle({ Name = "Vurgu (Highlight)", Desc = "Karakteri duvar arkasında boyar", CurrentValue = false, Flag = "ESPHighlight",
    Callback = function(Value) ESP.Highlight = Value ApplyESPStyle() end })

Visuals:CreateSlider({
    Name = "Vurgu şeffaflığı",
    Range = { 0, 1 },
    Increment = 0.05,
    CurrentValue = 0.7,
    Flag = "ESPFill",
    Callback = function(Value) ESP.Fill = Value ApplyESPStyle() end,
})

Visuals:CreateSection("Filtreler ve renkler")

Visuals:CreateToggle({ Name = "Takım kontrolü", Desc = "Takım arkadaşlarını gizle", CurrentValue = false, Flag = "ESPTeamCheck",
    Callback = function(Value) ESP.TeamCheck = Value end })
Visuals:CreateToggle({ Name = "Takım renklerini kullan", CurrentValue = false, Flag = "ESPTeamColor",
    Callback = function(Value) ESP.TeamColor = Value ApplyESPStyle() end })
Visuals:CreateToggle({ Name = "Seçili hedefi farklı renkle göster", Desc = "Oyuncu listesinden seçtiğin kişi ikinci tema renginde görünür", CurrentValue = true, Flag = "ESPTargetColor",
    Callback = function(Value) ESP.TargetColor = Value ApplyESPStyle() end })

Visuals:CreateColorPicker({
    Name = "ESP rengi",
    Color = ACCENT,
    Flag = "ESPColor",
    Callback = function(Color)
        ESP.Color = Color
        ApplyESPStyle()
    end,
})

Visuals:CreateSection("İşaretleme")

Visuals:CreateButton({
    Name = "İşaretli oyuncuları temizle",
    Desc = "Oyuncu listesinden ESP ile işaretlenenleri kaldırır",
    Icon = "square",
    Callback = function()
        local list = {}
        for p in pairs(UI.Marked) do table.insert(list, p) end
        UI.Marked = {}
        for _, p in ipairs(list) do BuildESP(p) end
    end,
})

local OrigLighting = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    FogEnd = Lighting.FogEnd,
    FogStart = Lighting.FogStart,
    GlobalShadows = Lighting.GlobalShadows,
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
}
local WorldState = { Fullbright = false, NoFog = false, NoShadows = false, FreezeTime = false, Clock = Lighting.ClockTime }

World:CreateSection("Işıklandırma")

World:CreateToggle({
    Name = "Fullbright",
    Desc = "Her yeri aydınlat",
    CurrentValue = false,
    Flag = "Fullbright",
    Callback = function(Value)
        WorldState.Fullbright = Value
        if not Value then
            Lighting.Brightness = OrigLighting.Brightness
            Lighting.Ambient = OrigLighting.Ambient
            Lighting.OutdoorAmbient = OrigLighting.OutdoorAmbient
        end
    end,
})

World:CreateToggle({
    Name = "Sisi kaldır",
    CurrentValue = false,
    Flag = "NoFog",
    Callback = function(Value)
        WorldState.NoFog = Value
        if not Value then
            Lighting.FogEnd = OrigLighting.FogEnd
            Lighting.FogStart = OrigLighting.FogStart
        end
    end,
})

World:CreateToggle({
    Name = "Gölgeleri kapat",
    CurrentValue = false,
    Flag = "NoShadows",
    Callback = function(Value)
        WorldState.NoShadows = Value
        if not Value then Lighting.GlobalShadows = OrigLighting.GlobalShadows end
    end,
})

World:CreateToggle({
    Name = "Günün saatini sabitle",
    CurrentValue = false,
    Flag = "FreezeTime",
    Callback = function(Value)
        WorldState.FreezeTime = Value
        if not Value then Lighting.ClockTime = OrigLighting.ClockTime end
    end,
})

World:CreateSlider({
    Name = "Saat",
    Range = { 0, 24 },
    Increment = 0.1,
    CurrentValue = 14,
    Flag = "ClockTime",
    Callback = function(Value)
        WorldState.Clock = Value
        if WorldState.FreezeTime then Lighting.ClockTime = Value end
    end,
})

World:CreateSection("Harita")

World:CreateButton({
    Name = "Doku / çıkartmaları gizle",
    Icon = "eraser",
    Callback = function()
        local n = 0
        for _, d in ipairs(Workspace:GetDescendants()) do
            if d:IsA("Decal") or d:IsA("Texture") then
                d.Transparency = 1
                n += 1
            end
        end
        Notify("Dünya", n .. " doku gizlendi.", "Success")
    end,
})

World:CreateButton({
    Name = "Düşük grafik (pürüzsüz plastik)",
    Icon = "cpu",
    Callback = function()
        for _, d in ipairs(Workspace:GetDescendants()) do
            if d:IsA("BasePart") then
                d.Material = Enum.Material.SmoothPlastic
                d.CastShadow = false
            end
        end
        Notify("Dünya", "Uygulandı.", "Success")
    end,
})

World:CreateSection("Kamera")

World:CreateToggle({
    Name = "Kamera zoom sınırını kaldır",
    Desc = "Sınırsız uzaklaş, istediğin kadar yakınlaş",
    CurrentValue = false,
    Flag = "CamUnlock",
    Callback = function(Value)
        State.CamUnlock = Value
        if Value then
            pcall(function()
                LP.CameraMaxZoomDistance = 100000
                LP.CameraMinZoomDistance = 0.5
            end)
        else
            pcall(function()
                LP.CameraMaxZoomDistance = State.CamMaxZoom
                LP.CameraMinZoomDistance = OrigCam.Min
            end)
        end
    end,
})

World:CreateToggle({
    Name = "Kamera duvarlardan geçsin",
    Desc = "Kamera duvarlara takılmaz, görüş engellenmez",
    CurrentValue = false,
    Flag = "CamNoOcclusion",
    Callback = function(Value)
        State.CamNoOcclusion = Value
        pcall(function()
            LP.DevCameraOcclusionMode = Value and Enum.DevCameraOcclusionMode.Invisicam or OrigCam.Occlusion
        end)
    end,
})

World:CreateSlider({
    Name = "Maksimum zoom mesafesi",
    Desc = "Zoom sınırı kaldırma kapalıyken geçerli",
    Range = { 10, 1000 },
    Increment = 10,
    CurrentValue = 128,
    Flag = "MaxZoom",
    Callback = function(Value)
        State.CamMaxZoom = Value
        if not State.CamUnlock then pcall(function() LP.CameraMaxZoomDistance = Value end) end
    end,
})

World:CreateToggle({
    Name = "Özel görüş açısı (FOV)",
    CurrentValue = false,
    Flag = "FOVToggle",
    Callback = function(Value)
        State.FOV = Value
        if not Value then Workspace.CurrentCamera.FieldOfView = 70 end
    end,
})

World:CreateSlider({
    Name = "Görüş açısı",
    Range = { 1, 120 },
    Increment = 1,
    CurrentValue = 70,
    Flag = "FOVValue",
    Callback = function(Value) State.FOVValue = Value end,
})

World:CreateSection("Ekran bilgisi (HUD)")

local HudGui = Instance.new("ScreenGui")
HudGui.Name = "HexionHUD"
HudGui.ResetOnSpawn = false
HudGui.DisplayOrder = 60
HudGui.Parent = GuiParent()

local Hud = Instance.new("TextLabel")
Hud.AutomaticSize = Enum.AutomaticSize.X
Hud.Size = UDim2.new(0, 0, 0, 30)
Hud.Position = UDim2.new(0.5, 0, 0, 10)
Hud.AnchorPoint = Vector2.new(0.5, 0)
Hud.BackgroundColor3 = Theme.Pal.PANEL
Hud.BackgroundTransparency = 0.1
Hud.BorderSizePixel = 0
Hud.Font = Enum.Font.GothamMedium
Hud.TextSize = 13
Hud.TextColor3 = Theme.Pal.TEXT
Hud.RichText = true
Hud.Text = ""
Hud.Parent = HudGui
Instance.new("UICorner", Hud).CornerRadius = UDim.new(1, 0)
local HudPad = Instance.new("UIPadding", Hud)
HudPad.PaddingLeft = UDim.new(0, 16)
HudPad.PaddingRight = UDim.new(0, 16)
local HudStroke = Instance.new("UIStroke", Hud)
HudStroke.Color = ACCENT
HudStroke.Transparency = 0.5
HudStroke.Thickness = 1.3

Theme.Bind(Hud, "BackgroundColor3", "PANEL")
Theme.Bind(Hud, "TextColor3", "TEXT")
Theme.Bind(HudStroke, "Color", "ACCENT")

World:CreateToggle({
    Name = "HUD'u göster",
    Desc = "Oyun adı, oyuncu sayısı, FPS, ping ve yapımcı",
    CurrentValue = true,
    Flag = "HudToggle",
    Callback = function(Value) HudGui.Enabled = Value end,
})

Misc:CreateSection("Sunucu")

Misc:CreateButton({
    Name = "Yeniden katıl",
    Style = "Primary",
    Icon = "log-in",
    Callback = function()
        if #Players:GetPlayers() <= 1 then
            LP:Kick("\nYeniden katılınıyor...")
            task.wait()
            TeleportService:Teleport(game.PlaceId, LP)
        else
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LP)
        end
    end,
})

Misc:CreateButton({
    Name = "Sunucu değiştir",
    Icon = "shuffle",
    Callback = function()
        Notify("Sunucu değiştir", "Sunucu aranıyor...", "Info")
        task.spawn(function()
            local ok, result = pcall(function()
                local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
                return HttpService:JSONDecode(game:HttpGet(url))
            end)
            if not ok or not result or not result.data then
                Notify("Sunucu değiştir", "Sunucu listesi alınamadı.", "Error")
                return
            end
            local choices = {}
            for _, s in ipairs(result.data) do
                if s.id ~= game.JobId and s.playing and s.maxPlayers and s.playing < s.maxPlayers then
                    table.insert(choices, s.id)
                end
            end
            if #choices == 0 then
                Notify("Sunucu değiştir", "Başka sunucu bulunamadı.", "Warning")
                return
            end
            TeleportService:TeleportToPlaceInstance(game.PlaceId, choices[math.random(1, #choices)], LP)
        end)
    end,
})

Misc:CreateButton({
    Name = "JobId kopyala",
    Icon = "copy",
    Callback = function()
        Notify("Çeşitli", CopyText(game.JobId) and "JobId kopyalandı." or "Panoya kopyalama desteklenmiyor.", "Info")
    end,
})

Misc:CreateButton({
    Name = "PlaceId kopyala",
    Icon = "copy",
    Callback = function()
        Notify("Çeşitli", CopyText(tostring(game.PlaceId)) and "PlaceId kopyalandı." or "Panoya kopyalama desteklenmiyor.", "Info")
    end,
})

Misc:CreateSection("Performans")

Misc:CreateSlider({
    Name = "FPS sınırı",
    Range = { 15, 360 },
    Increment = 5,
    CurrentValue = 60,
    Flag = "FPSCap",
    Callback = function(Value)
        if setfpscap then pcall(setfpscap, Value) end
    end,
})

Misc:CreateSection("Eşyalar")

Misc:CreateButton({
    Name = "Tüm eşyaları kuşan",
    Icon = "briefcase",
    Callback = function()
        local hum = GetHumanoid()
        if not hum then return end
        for _, t in ipairs(LP.Backpack:GetChildren()) do
            if t:IsA("Tool") then hum:EquipTool(t) end
        end
    end,
})

Misc:CreateButton({
    Name = "Eşyaları çıkar",
    Icon = "briefcase",
    Callback = function()
        local hum = GetHumanoid()
        if hum then hum:UnequipTools() end
    end,
})

Misc:CreateButton({
    Name = "Kamerayı sıfırla",
    Icon = "camera",
    Callback = function()
        local hum = GetHumanoid()
        if hum then Workspace.CurrentCamera.CameraSubject = hum end
        Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    end,
})

Misc:CreateSection("Bildirimler ve bilgi")

Misc:CreateToggle({
    Name = "Giriş / çıkış bildirimi",
    Desc = "Biri sunucuya girince veya çıkınca haber verir",
    CurrentValue = false,
    Flag = "JoinAlerts",
    Callback = function(Value) State.JoinAlerts = Value end,
})

Misc:CreateButton({
    Name = "Sunucu bilgisini göster",
    Desc = "Oyun adı, oyuncu sayısı ve PlaceId",
    Icon = "info",
    Callback = function()
        Notify("Sunucu", GameName .. "  ·  " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers .. " oyuncu  ·  " .. game.PlaceId, "Info")
    end,
})

Settings:CreateSection("Arayüz")

Settings:CreateThemePicker({ Flag = "Theme" })

Settings:CreateDropdown({
    Name = "Panel teması",
    Desc = "Oyuncu listesi, kitaplık, oyuncu kartı ve HUD renkleri",
    Options = Theme.Order,
    CurrentOption = Theme.Default,
    Flag = "PanelTheme",
    Callback = function(Option)
        if type(Option) == "table" then Option = Option[1] end
        local pal = Theme.Presets[Option]
        if pal then UI.ApplyTheme(pal) end
    end,
})

Settings:CreateKeybind({
    Name = "Menüyü aç/kapat tuşu",
    CurrentKeybind = "RightControl",
    OnChanged = function(Key)
        Window:SetKeybind(Key)
    end,
})

Settings:CreateConfigManager({ Name = "Ayar dosyaları" })

Settings:CreateButton({
    Name = "Liste ve kitaplık temasını menüyle eşitle",
    Desc = "Oyuncu listesi ve kitaplık, menünün renk ve yazı tipini alır",
    Icon = "check",
    Callback = function()
        if UI.SyncTheme() then
            Notify("Tema", "Panel menüyle eşitlendi.", "Success")
        else
            Notify("Tema", "Menü rengi okunamadı, varsayılan tema kullanılıyor.", "Warning")
        end
    end,
})

Settings:CreateSection("Yapımcı: " .. CREATOR)

Settings:CreateButton({
    Name = "Yapımcı: " .. CREATOR,
    Icon = "heart",
    Callback = function()
        Notify("Hexion v10", "Bu menü " .. CREATOR .. " tarafından yapıldı.", "Success")
    end,
})

local function Cleanup()
    for _, c in ipairs(Connections) do pcall(function() c:Disconnect() end) end
    Connections = {}
    for _, p in ipairs(Players:GetPlayers()) do ClearESP(p) end
    if State.Listen then ListenSavedCF = nil SetListen(false) end
    StopCustom()
    StopCopy()
    StopFly()
    local root, hum = GetRoot(), GetHumanoid()
    if root then root.Anchored = false end
    if hum then
        hum.WalkSpeed = 16
        hum.JumpPower = 50
        Workspace.CurrentCamera.CameraSubject = hum
    end
    Workspace.Gravity = OriginalGravity
    Workspace.CurrentCamera.FieldOfView = 70
    for k, v in pairs(OrigLighting) do pcall(function() Lighting[k] = v end) end
    pcall(function()
        LP.CameraMaxZoomDistance = OrigCam.Max
        LP.CameraMinZoomDistance = OrigCam.Min
        LP.DevCameraOcclusionMode = OrigCam.Occlusion
    end)
    RestoreNoclip()
    pcall(function() SoundService:SetListener(Enum.ListenerType.Camera) end)
    pcall(function() CardGui:Destroy() end)
    pcall(function() PL.Gui:Destroy() end)
    pcall(function() LibGui:Destroy() end)
    pcall(function() ESP.Folder:Destroy() end)
    pcall(function() HudGui:Destroy() end)
    State.Speed, State.Jump, State.Noclip, State.Fly, State.CopyAnim = false, false, false, false, false
    State.Spin, State.Bhop, State.ClickTP, State.AntiVoid = false, false, false, false
    State.Follow, State.Orbit, State.Stick, State.CFrameSpeed = false, false, false, false
    State.CamUnlock, State.CamNoOcclusion = false, false
end

Settings:CreateButton({
    Name = "Kaldır (Unload)",
    Icon = "power",
    Style = "Danger",
    Callback = function()
        Airflow:Confirm({
            Title = "Kaldırılsın mı?",
            Content = "Hexion kaldırılacak ve her şey sıfırlanacak.",
            ConfirmText = "Kaldır",
            Callback = function()
                Cleanup()
                Window:Destroy()
            end,
        })
    end,
})

local espTick = 0
local miscTick = 0
local uiTick = 0
local orbitAngle = 0
local lastSafe
local fpsSmooth = 60

Connect(RunService.RenderStepped, function(dt)
    local cam = Workspace.CurrentCamera
    local hum = GetHumanoid()
    local root = GetRoot()

    fpsSmooth = fpsSmooth + ((1 / math.max(dt, 1e-4)) - fpsSmooth) * 0.05

    if State.CamUnlock then
        pcall(function()
            LP.CameraMinZoomDistance = 0.5
            LP.CameraMaxZoomDistance = 100000
        end)
    end

    if hum then
        if State.Speed then hum.WalkSpeed = State.SpeedValue end
        if State.Jump then
            hum.UseJumpPower = true
            hum.JumpPower = State.JumpValue
        end
        if State.Bhop and UserInputService:IsKeyDown(Enum.KeyCode.Space) and hum.FloorMaterial ~= Enum.Material.Air then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end

    if State.CFrameSpeed and hum and root and not State.Fly then
        local md = hum.MoveDirection
        if md.Magnitude > 0 then
            root.CFrame = root.CFrame + md * (State.CFrameSpeedValue * dt * 10)
        end
    end

    if State.Gravity then Workspace.Gravity = State.GravityValue end
    if State.FOV and cam then cam.FieldOfView = State.FOVValue end

    if State.Spin and root and not State.Fly then
        root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(State.SpinSpeed * 10 * dt * 6), 0)
    end

    if State.Fly and FlyBV and FlyBG then
        local dir = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.yAxis end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.yAxis end
        FlyBV.Velocity = dir.Magnitude > 0 and dir.Unit * State.FlySpeed or Vector3.zero
        FlyBG.CFrame = cam.CFrame
    end

    local t = State.Target
    local troot = t and t.Character and t.Character:FindFirstChild("HumanoidRootPart")
    if troot and root and hum and not State.Listen then
        if State.Orbit then
            orbitAngle += dt * State.OrbitSpeed
            local pos = troot.Position + Vector3.new(math.cos(orbitAngle) * State.OrbitRadius, 0, math.sin(orbitAngle) * State.OrbitRadius)
            root.CFrame = CFrame.lookAt(pos, Vector3.new(troot.Position.X, pos.Y, troot.Position.Z))
        elseif State.Stick then
            root.CFrame = troot.CFrame * CFrame.new(0, 0, 3)
        elseif State.Follow then
            hum:MoveTo(troot.Position)
        end
    end

    if State.AntiVoid and root and not State.Listen then
        if root.Position.Y > Workspace.FallenPartsDestroyHeight + 60 and hum and hum.FloorMaterial ~= Enum.Material.Air then
            lastSafe = root.CFrame
        elseif root.Position.Y < Workspace.FallenPartsDestroyHeight + 40 and lastSafe then
            root.AssemblyLinearVelocity = Vector3.zero
            root.CFrame = lastSafe + Vector3.new(0, 4, 0)
        end
    end

    miscTick += dt
    if miscTick >= 0.3 then
        miscTick = 0
        if State.Spectate and troot then
            local th = t.Character:FindFirstChildOfClass("Humanoid")
            if th and cam.CameraSubject ~= th then cam.CameraSubject = th end
        end
        if State.CamUnlock then
            pcall(function()
                LP.CameraMaxZoomDistance = 100000
                LP.CameraMinZoomDistance = 0.5
            end)
        end
        if State.CamNoOcclusion then
            pcall(function() LP.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Invisicam end)
        end
    end

    uiTick += dt
    if uiTick >= 0.5 then
        uiTick = 0
        UpdateListState()
        local ping = 0
        pcall(function()
            ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue() + 0.5)
        end)
        Hud.Text = string.format(
            '<font color="%s"><b>HEXION v10</b></font>  •  Yapımcı: <b>%s</b>  •  %s  •  %d oyuncu  •  %d FPS  •  %d ms',
            UI.Rgb(UI.C.ACCENT), CREATOR, GameName, #Players:GetPlayers(), math.floor(fpsSmooth + 0.5), ping
        )
    end

    if WorldState.Fullbright then
        Lighting.Brightness = 2
        Lighting.Ambient = Color3.fromRGB(178, 178, 178)
        Lighting.OutdoorAmbient = Color3.fromRGB(178, 178, 178)
    end
    if WorldState.NoFog then
        Lighting.FogEnd = 1e9
        Lighting.FogStart = 1e9
    end
    if WorldState.NoShadows then Lighting.GlobalShadows = false end
    if WorldState.FreezeTime then Lighting.ClockTime = WorldState.Clock end

    if ESP.Enabled or next(UI.Marked) ~= nil then
        espTick += dt
        local tick10 = espTick >= 0.1
        if tick10 then espTick = 0 end
        local myRoot = root
        local vp = cam.ViewportSize

        for p, o in pairs(ESP.Objects) do
            if o.Root and o.Root.Parent and myRoot then
                if tick10 then ESP.Update(p, o, myRoot) end
                ESP.Frame(o, cam, vp)
            else
                ESP.Hide(o)
            end
        end
    end
end)

Connect(RunService.Stepped, function()
    if State.Noclip then
        local ch = LP.Character
        if ch then
            for _, part in ipairs(ch:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    NoclipParts[part] = true
                    part.CanCollide = false
                end
            end
        end
    end
end)

Connect(RunService.Heartbeat, function()
    if State.CopyAnim and State.Target then CopyStep() end
end)

Connect(UserInputService.JumpRequest, function()
    if State.InfJump then
        local h = GetHumanoid()
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

Connect(UserInputService.InputBegan, function(input, processed)
    if processed then return end
    if State.ClickTP and input.UserInputType == Enum.UserInputType.MouseButton1
        and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        local root = GetRoot()
        if root and Mouse.Hit then
            root.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0))
        end
    end
end)

Connect(LP.Idled, function()
    if State.AntiAFK then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

Connect(LP.CharacterAdded, function(ch)
    if State.Listen then ListenSavedCF = nil SetListen(false) end
    CurrentTrack = nil
    CopyTracks = {}
    NoclipParts = {}
    OriginalAnims = {}
    FlyBV, FlyBG = nil, nil
    lastSafe = nil
    if State.Freeze then
        local root = ch:WaitForChild("HumanoidRootPart", 5)
        if root then root.Anchored = true end
    end
    if State.Fly then
        task.wait(0.5)
        StartFly()
    end
end)

do
    local TR = { Mode = "Kafaya otur", Dist = 3, Speed = 6, Conn = nil, Spam = false }
    local ModeList = { "Kafaya otur", "Sırtına bin", "Yüz yüze", "Gölge (arkasında)", "Hortum", "Helikopter", "Titreme", "Ters dönüş", "Ölü taklidi" }
    local NeedsTarget = { ["Kafaya otur"] = true, ["Sırtına bin"] = true, ["Yüz yüze"] = true, ["Gölge (arkasında)"] = true, ["Hortum"] = true }

    local function TargetParts()
        local t = State.Target
        local c = t and t.Character
        if not c then return nil end
        return c:FindFirstChild("HumanoidRootPart"), c:FindFirstChild("Head")
    end

    local function Stop(silent)
        if TR.Conn then TR.Conn:Disconnect() TR.Conn = nil end
        TR.Active = nil
        local hum, root = GetHumanoid(), GetRoot()
        if hum then hum.Sit = false hum.PlatformStand = false end
        if root then
            root.AssemblyLinearVelocity = Vector3.zero
            root.AssemblyAngularVelocity = Vector3.zero
            local p = root.Position
            local _, yaw = root.CFrame:ToEulerAnglesYXZ()
            root.CFrame = CFrame.new(p + Vector3.new(0, 2, 0)) * CFrame.Angles(0, yaw, 0)
        end
        if not silent then Notify("Troll", "Durduruldu.", "Info") end
    end

    local function Start(mode)
        if TR.Conn then TR.Conn:Disconnect() TR.Conn = nil end
        if NeedsTarget[mode] and not State.Target then
            Notify("Troll", "Önce Oyuncular sekmesinden bir hedef seç.", "Warning")
            return
        end
        TR.Active = mode
        local t0 = os.clock()
        local startY
        TR.Conn = RunService.Heartbeat:Connect(function(dt)
            local root, hum = GetRoot(), GetHumanoid()
            if not root or not hum or hum.Health <= 0 then return end
            local el = os.clock() - t0
            if NeedsTarget[mode] then
                if not State.Target or not State.Target.Parent then
                    Stop(true)
                    Notify("Troll", "Hedef kayboldu, durduruldu.", "Warning")
                    return
                end
            end
            root.AssemblyLinearVelocity = Vector3.zero
            if mode == "Kafaya otur" then
                local tr, th = TargetParts()
                if not tr then return end
                local head = th or tr
                hum.Sit = true
                root.CFrame = head.CFrame * CFrame.new(0, head.Size.Y / 2 + 1.2, 0)
            elseif mode == "Sırtına bin" then
                local tr = TargetParts()
                if not tr then return end
                hum.Sit = true
                root.CFrame = tr.CFrame * CFrame.new(0, 0.7, 0.9)
            elseif mode == "Yüz yüze" then
                local tr = TargetParts()
                if not tr then return end
                local pos = (tr.CFrame * CFrame.new(0, 0, -TR.Dist)).Position
                root.CFrame = CFrame.new(pos, Vector3.new(tr.Position.X, pos.Y, tr.Position.Z))
            elseif mode == "Gölge (arkasında)" then
                local tr = TargetParts()
                if not tr then return end
                root.CFrame = tr.CFrame * CFrame.new(0, 0, TR.Dist)
            elseif mode == "Hortum" then
                local tr = TargetParts()
                if not tr then return end
                local a = el * TR.Speed
                local r = TR.Dist + 2
                local pos = tr.Position + Vector3.new(math.cos(a) * r, 2 + math.sin(el * 2) * 3, math.sin(a) * r)
                root.CFrame = CFrame.new(pos, tr.Position)
            elseif mode == "Helikopter" then
                startY = startY or root.Position.Y
                local y = startY + math.min(el * 8, 14)
                root.CFrame = CFrame.new(root.Position.X, y, root.Position.Z) * CFrame.Angles(0, el * TR.Speed * 3, 0)
            elseif mode == "Titreme" then
                local k = TR.Speed * 0.04
                root.CFrame = root.CFrame * CFrame.new((math.random() - 0.5) * k, 0, (math.random() - 0.5) * k) * CFrame.Angles(0, (math.random() - 0.5) * 0.3, 0)
            elseif mode == "Ters dönüş" then
                hum.PlatformStand = true
                root.CFrame = CFrame.new(root.Position) * CFrame.Angles(math.pi, el * TR.Speed * 0.5, 0)
            elseif mode == "Ölü taklidi" then
                hum.PlatformStand = true
                root.CFrame = CFrame.new(root.Position) * CFrame.Angles(-math.pi / 2, 0, 0)
            end
        end)
        Notify("Troll", mode .. " başladı.", "Success")
    end

    Troll:CreateSection("Hedef bazlı")
    Troll:CreateDropdown({
        Name = "Mod",
        Desc = "İlk 5 mod hedef ister (Oyuncular sekmesinden seç)",
        Options = ModeList,
        CurrentOption = "Kafaya otur",
        Flag = "TrollMode",
        Callback = function(Option)
            if type(Option) == "table" then Option = Option[1] end
            TR.Mode = Option or "Kafaya otur"
        end,
    })
    Troll:CreateSlider({ Name = "Mesafe", Range = { 1, 15 }, Increment = 0.5, CurrentValue = 3, Flag = "TrollDist", Callback = function(V) TR.Dist = V end })
    Troll:CreateSlider({ Name = "Hız", Range = { 1, 20 }, Increment = 1, CurrentValue = 6, Flag = "TrollSpeed", Callback = function(V) TR.Speed = V end })
    Troll:CreateButton({ Name = "Başlat", Style = "Primary", Icon = "play", Callback = function() Start(TR.Mode) end })
    Troll:CreateButton({ Name = "Durdur", Icon = "square", Callback = function() Stop(false) end })
    Troll:CreateButton({
        Name = "Hedefi göster",
        Icon = "eye",
        Callback = function()
            local t = State.Target
            Notify("Troll", t and ("Hedef: " .. t.DisplayName .. " (@" .. t.Name .. ")") or "Hedef seçilmedi.", t and "Info" or "Warning")
        end,
    })

    Connect(LP.CharacterAdded, function()
        if TR.Active then task.wait(0.6) Start(TR.Active) end
    end)
end

do
    local P = Theme.Pal
    local NB = {
        PromptESP = false, ItemESP = false, NPCESP = false,
        Alert = false, AlertDist = 40,
        Instant = false, NoLOS = false, RangeMul = 1,
        Auto = false, AutoRange = 12, Keyword = "",
        Light = false, LightRange = 60, LightBright = 2.5,
    }
    local Folder = Instance.new("Folder")
    Folder.Name = "HexionNB"
    Folder.Parent = GuiParent()

    local Prompts, Items, NPCs = {}, {}, {}
    local Orig = setmetatable({}, { __mode = "k" })
    local Marks = {}
    local LastFire = setmetatable({}, { __mode = "k" })

    local function PartOf(inst)
        if not inst then return nil end
        if inst:IsA("BasePart") then return inst end
        if inst:IsA("Attachment") and inst.Parent and inst.Parent:IsA("BasePart") then return inst.Parent end
        if inst:IsA("Model") then return inst.PrimaryPart or inst:FindFirstChildWhichIsA("BasePart", true) end
        return inst:FindFirstAncestorWhichIsA("BasePart") or inst:FindFirstChildWhichIsA("BasePart", true)
    end
    local function PromptName(pp)
        local n = pp.ObjectText ~= "" and pp.ObjectText or (pp.Parent and pp.Parent.Name or "?")
        return n, pp.ActionText
    end
    local function Matches(text)
        local k = string.lower(NB.Keyword or "")
        if k == "" then return true end
        return string.find(string.lower(text), k, 1, true) ~= nil
    end
    local function PromptText(pp)
        local n, a = PromptName(pp)
        return n .. " " .. a .. " " .. (pp.Parent and pp.Parent.Name or "")
    end
    local function ColorFor(text)
        text = string.lower(text)
        if string.find(text, "key") or string.find(text, "anahtar") then return P.WARN end
        if string.find(text, "door") or string.find(text, "kap") or string.find(text, "gate") then return P.ACCENT2 end
        return P.GOOD
    end

    local function ApplyPrompt(pp)
        local o = Orig[pp]
        if not o then
            o = { Hold = pp.HoldDuration, Dist = pp.MaxActivationDistance, LOS = pp.RequiresLineOfSight }
            Orig[pp] = o
        end
        pp.HoldDuration = NB.Instant and 0 or o.Hold
        pp.MaxActivationDistance = o.Dist * NB.RangeMul
        pp.RequiresLineOfSight = NB.NoLOS and false or o.LOS
    end
    local function ReapplyAll()
        for pp in pairs(Prompts) do
            if pp.Parent then pcall(ApplyPrompt, pp) end
        end
    end

    local function Classify(d)
        if d:IsA("ProximityPrompt") then
            Prompts[d] = true
            pcall(ApplyPrompt, d)
        elseif d:IsA("ClickDetector") then
            Items[d] = "click"
        elseif d:IsA("Tool") and d.Parent and not Players:GetPlayerFromCharacter(d.Parent) and not d:IsDescendantOf(Players) then
            Items[d] = "tool"
        elseif d:IsA("Humanoid") then
            local m = d.Parent
            if m and m:IsA("Model") and not Players:GetPlayerFromCharacter(m) then NPCs[m] = d end
        end
    end
    task.spawn(function()
        local n = 0
        for _, d in ipairs(Workspace:GetDescendants()) do
            Classify(d)
            n = n + 1
            if n % 1500 == 0 then task.wait() end
        end
    end)
    Connect(Workspace.DescendantAdded, function(d) pcall(Classify, d) end)
    Connect(Workspace.DescendantRemoving, function(d)
        Prompts[d], Items[d], NPCs[d] = nil, nil, nil
        if d:IsA("Humanoid") and d.Parent then NPCs[d.Parent] = nil end
    end)

    local function Unmark(inst)
        local m = Marks[inst]
        if m then
            for _, i in ipairs(m.Inst) do pcall(function() i:Destroy() end) end
            Marks[inst] = nil
        end
    end
    local function Mark(inst, part, color, withHL)
        if Marks[inst] then return Marks[inst] end
        if not part then return nil end
        local m = { Inst = {}, Part = part }
        local bb = Instance.new("BillboardGui")
        bb.Size = UDim2.new(0, 170, 0, 34)
        bb.AlwaysOnTop = true
        bb.LightInfluence = 0
        bb.StudsOffset = Vector3.new(0, 2, 0)
        bb.MaxDistance = math.huge
        bb.Adornee = part
        bb.Parent = Folder
        local card = Instance.new("Frame")
        card.Size = UDim2.new(1, 0, 1, 0)
        card.BackgroundColor3 = Color3.fromRGB(13, 13, 18)
        card.BackgroundTransparency = 0.15
        card.BorderSizePixel = 0
        card.Parent = bb
        local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 9) c.Parent = card
        local st = Instance.new("UIStroke") st.Color = color st.Thickness = 1.4 st.Transparency = 0.15 st.Parent = card
        local lb = Instance.new("TextLabel")
        lb.BackgroundTransparency = 1
        lb.Size = UDim2.new(1, -8, 1, 0)
        lb.Position = UDim2.new(0, 4, 0, 0)
        lb.Font = Enum.Font.GothamMedium
        lb.TextSize = 12
        lb.TextColor3 = Color3.new(1, 1, 1)
        lb.RichText = true
        lb.Parent = card
        m.Label, m.Stroke, m.Color = lb, st, color
        table.insert(m.Inst, bb)
        if withHL then
            local hl = Instance.new("Highlight")
            hl.FillColor = color
            hl.OutlineColor = color:Lerp(Color3.new(1, 1, 1), 0.5)
            hl.FillTransparency = 0.75
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.Adornee = inst:IsA("Model") and inst or part
            hl.Parent = Folder
            table.insert(m.Inst, hl)
        end
        Marks[inst] = m
        return m
    end
    local function Dist(root, part)
        if not root or not part then return 0 end
        return math.floor((root.Position - part.Position).Magnitude)
    end
    local function Hex(c) return string.format("rgb(%d,%d,%d)", c.R * 255, c.G * 255, c.B * 255) end

    local lastAlert = 0
    local function Tick()
        local root = GetRoot()
        for pp in pairs(Prompts) do
            if not pp.Parent then
                Prompts[pp] = nil
                Unmark(pp)
            elseif NB.PromptESP and pp.Enabled and Matches(PromptText(pp)) then
                local part = PartOf(pp.Parent)
                local m = Mark(pp, part, ColorFor(PromptText(pp)), false)
                if m then
                    local n, a = PromptName(pp)
                    m.Label.Text = "<b>" .. n .. "</b>  " .. Dist(root, part) .. "m\n<font color=\"" .. Hex(m.Color) .. "\">" .. (a ~= "" and a or "Etkileşim") .. "</font>"
                end
            else
                Unmark(pp)
            end
        end
        for it, kind in pairs(Items) do
            if not it.Parent then
                Items[it] = nil
                Unmark(it)
            elseif NB.ItemESP then
                local target = (kind == "tool") and (it:FindFirstChild("Handle") or PartOf(it)) or PartOf(it.Parent)
                local label = (kind == "tool") and it.Name or (it.Parent and it.Parent.Name or "?")
                if target and Matches(label) then
                    local m = Mark(it, target, kind == "tool" and P.WARN or P.ACCENT, false)
                    if m then m.Label.Text = "<b>" .. label .. "</b>  " .. Dist(root, target) .. "m\n" .. (kind == "tool" and "Eşya" or "Tıklanabilir") end
                else
                    Unmark(it)
                end
            else
                Unmark(it)
            end
        end
        local nearest, nd = nil, math.huge
        for model, hum in pairs(NPCs) do
            if not model.Parent or not hum.Parent then
                NPCs[model] = nil
                Unmark(model)
            else
                local part = model:FindFirstChild("HumanoidRootPart") or PartOf(model)
                if part and root then
                    local d = (root.Position - part.Position).Magnitude
                    if d < nd then nearest, nd = model, d end
                end
                if NB.NPCESP and part then
                    local m = Mark(model, part, P.BAD, true)
                    if m then m.Label.Text = "<b>" .. model.Name .. "</b>  " .. Dist(root, part) .. "m\nCan: " .. math.floor(hum.Health) end
                else
                    Unmark(model)
                end
            end
        end
        if NB.Alert and nearest and nd <= NB.AlertDist and os.clock() - lastAlert > 4 then
            lastAlert = os.clock()
            Notify("Yakında!", nearest.Name .. " seni yaklaşık " .. math.floor(nd) .. " birim uzaktan görebilir.", "Warning")
        end
        local ch = LP.Character
        local head = ch and ch:FindFirstChild("Head")
        if head then
            local l = head:FindFirstChild("HexionLight")
            if NB.Light then
                if not l then
                    l = Instance.new("PointLight")
                    l.Name = "HexionLight"
                    l.Color = Color3.fromRGB(255, 240, 215)
                    l.Shadows = false
                    l.Parent = head
                end
                l.Range, l.Brightness = NB.LightRange, NB.LightBright
            elseif l then
                l:Destroy()
            end
        end
    end
    task.spawn(function()
        while task.wait(0.3) do pcall(Tick) end
    end)

    task.spawn(function()
        while task.wait(0.15) do
            if NB.Auto and fireproximityprompt then
                local root = GetRoot()
                if root then
                    for pp in pairs(Prompts) do
                        if pp.Parent and pp.Enabled and Matches(PromptText(pp)) then
                            local part = PartOf(pp.Parent)
                            if part and (root.Position - part.Position).Magnitude <= NB.AutoRange and os.clock() - (LastFire[pp] or 0) > 1 then
                                LastFire[pp] = os.clock()
                                pcall(fireproximityprompt, pp)
                            end
                        end
                    end
                end
            end
        end
    end)

    local function Count(t) local n = 0 for _ in pairs(t) do n = n + 1 end return n end

    Nb:CreateSection("Etkileşim (ProximityPrompt)")
    Nb:CreateToggle({ Name = "Etkileşim ESP", Desc = "Kapı, anahtar ve diğer etkileşim noktalarını etiketler", CurrentValue = false, Flag = "NBPromptESP", Callback = function(V) NB.PromptESP = V end })
    Nb:CreateToggle({ Name = "Anında etkileşim", Desc = "Basılı tutma süresini sıfırlar", CurrentValue = false, Flag = "NBInstant", Callback = function(V) NB.Instant = V ReapplyAll() end })
    Nb:CreateToggle({ Name = "Duvar arkasından etkileşim", Desc = "Görüş hattı şartını kaldırır", CurrentValue = false, Flag = "NBNoLOS", Callback = function(V) NB.NoLOS = V ReapplyAll() end })
    Nb:CreateSlider({ Name = "Etkileşim menzili", Range = { 1, 6 }, Increment = 0.5, Suffix = "x", CurrentValue = 1, Flag = "NBRange", Callback = function(V) NB.RangeMul = V ReapplyAll() end })
    Nb:CreateInput({
        Name = "Anahtar kelime filtresi",
        Desc = "ESP, otomatik etkileşim ve ışınlanma için (örn. key, kapı). Boş = hepsi",
        PlaceholderText = "örn. key",
        MaxLength = 30,
        Flag = "NBKeyword",
        Callback = function(Text) NB.Keyword = Text or "" end,
    })
    Nb:CreateToggle({
        Name = "Otomatik etkileşim",
        Desc = fireproximityprompt and "Menzildeki (filtreye uyan) noktaları otomatik tetikler" or "Executor'ında fireproximityprompt yok",
        CurrentValue = false,
        Flag = "NBAuto",
        Callback = function(V) NB.Auto = V end,
    })
    Nb:CreateSlider({ Name = "Otomatik etkileşim menzili", Range = { 4, 40 }, Increment = 1, CurrentValue = 12, Flag = "NBAutoRange", Callback = function(V) NB.AutoRange = V end })
    Nb:CreateButton({
        Name = "En yakın etkileşime ışınlan",
        Icon = "map-pin",
        Callback = function()
            local root = GetRoot()
            if not root then return end
            local best, bd
            for pp in pairs(Prompts) do
                if pp.Parent and pp.Enabled and Matches(PromptText(pp)) then
                    local part = PartOf(pp.Parent)
                    if part then
                        local d = (root.Position - part.Position).Magnitude
                        if d > 6 and (not bd or d < bd) then best, bd = part, d end
                    end
                end
            end
            if best then
                root.CFrame = best.CFrame * CFrame.new(0, 3, 4)
                Notify("Komşular", "Işınlandın (" .. math.floor(bd) .. " birim).", "Success")
            else
                Notify("Komşular", "Uygun etkileşim noktası bulunamadı.", "Warning")
            end
        end,
    })

    Nb:CreateSection("Eşya ve tıklanabilirler")
    Nb:CreateToggle({ Name = "Eşya ve ClickDetector ESP", Desc = "Yerdeki eşyaları ve tıklanabilir nesneleri etiketler", CurrentValue = false, Flag = "NBItemESP", Callback = function(V) NB.ItemESP = V end })
    Nb:CreateButton({
        Name = "Yakındaki tıklanabilirleri tıkla",
        Desc = "20 birim içindeki ClickDetector'ları tetikler",
        Icon = "check",
        Callback = function()
            if not fireclickdetector then Notify("Komşular", "Executor'ında fireclickdetector yok.", "Error") return end
            local root, n = GetRoot(), 0
            if not root then return end
            for it, kind in pairs(Items) do
                if kind == "click" and it.Parent then
                    local part = PartOf(it.Parent)
                    if part and (root.Position - part.Position).Magnitude <= 20 and Matches(it.Parent.Name) then
                        pcall(fireclickdetector, it)
                        n = n + 1
                    end
                end
            end
            Notify("Komşular", n .. " nesne tıklandı.", n > 0 and "Success" or "Warning")
        end,
    })

    Nb:CreateSection("Komşu / NPC")
    Nb:CreateToggle({ Name = "NPC ESP", Desc = "Oyuncu olmayan karakterleri (komşu, canavar) kırmızı boyar", CurrentValue = false, Flag = "NBNPCESP", Callback = function(V) NB.NPCESP = V end })
    Nb:CreateToggle({ Name = "Yakınlık uyarısı", Desc = "NPC belirlenen mesafeye girince bildirim verir", CurrentValue = false, Flag = "NBAlert", Callback = function(V) NB.Alert = V end })
    Nb:CreateSlider({ Name = "Uyarı mesafesi", Range = { 10, 120 }, Increment = 5, CurrentValue = 40, Flag = "NBAlertDist", Callback = function(V) NB.AlertDist = V end })

    Nb:CreateSection("Görüş")
    Nb:CreateToggle({ Name = "El feneri", Desc = "Karakterine nokta ışığı ekler (karanlık haritalar için)", CurrentValue = false, Flag = "NBLight", Callback = function(V) NB.Light = V end })
    Nb:CreateSlider({ Name = "Fener menzili", Range = { 15, 120 }, Increment = 5, CurrentValue = 60, Flag = "NBLightRange", Callback = function(V) NB.LightRange = V end })
    Nb:CreateSlider({ Name = "Fener parlaklığı", Range = { 0.5, 6 }, Increment = 0.1, CurrentValue = 2.5, Flag = "NBLightBright", Callback = function(V) NB.LightBright = V end })

    Nb:CreateSection("Bilgi")
    Nb:CreateButton({
        Name = "Haritayı tara",
        Desc = "Bulunan etkileşim, eşya ve NPC sayısını gösterir",
        Icon = "refresh-cw",
        Callback = function()
            Notify("Komşular", "Etkileşim: " .. Count(Prompts) .. "  ·  Eşya/tıklanabilir: " .. Count(Items) .. "  ·  NPC: " .. Count(NPCs), "Info")
        end,
    })
end

local function HookPlayer(p)
    if p == LP then return end
    Connect(p.CharacterAdded, function()
        task.wait(0.5)
        BuildESP(p)
    end)
    Connect(p:GetPropertyChangedSignal("Team"), function()
        ApplyESPStyle()
    end)
    if p.Character then BuildESP(p) end
end

for _, p in ipairs(Players:GetPlayers()) do HookPlayer(p) end

Connect(Players.PlayerAdded, function(p)
    if State.JoinAlerts then Notify("Sunucu", p.DisplayName .. " katıldı.", "Info") end
    HookPlayer(p)
    RefreshPlayers()
    RefreshList()
end)

Connect(Players.PlayerRemoving, function(p)
    if State.JoinAlerts then Notify("Sunucu", p.DisplayName .. " ayrıldı.", "Info") end
    ClearESP(p)
    if State.Target == p then
        SetSpectate(false)
        SetListen(false)
        SetTarget(nil)
        State.CopyAnim = false
        State.Follow, State.Orbit, State.Stick = false, false, false
        StopCopy()
    end
    RefreshPlayers()
    task.defer(RefreshList)
end)

RefreshList()
UpdateListState()

Window:LoadConfig()

Notify("Hexion", "v10 yüklendi. Yapımcı: " .. CREATOR, "Success")
