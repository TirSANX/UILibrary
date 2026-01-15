repeat wait() until game:IsLoaded()
-- Use loadstring to avoid "nil value" errors with sharedRequire
--[=[
    Optimized UI Library (Fixed)
    - Fixed UI resizing visual bugs (Green Button)
    - Added ClipsDescendants to containers
    - Switched to Scale-based sizing for smooth animations
    - Removed redundant updateChildSizes logic
]=]
local Theme = {
    Colors = {
        -- New Theme
        MainBack = Color3.fromRGB(30, 30, 35),       -- Sidebar Color
        ContentBack = Color3.fromRGB(25, 25, 30),    -- Main Background
        SectionBack = Color3.fromRGB(35, 35, 40),    -- Collapsible Section Background
        ElementBack = Color3.fromRGB(45, 45, 50),    -- Buttons, Inputs etc.
        Text = Color3.fromRGB(220, 220, 220),        -- Main Text
        Primary = Color3.fromRGB(220, 20, 60),       -- Accent Color (Crimson Red)
        Hover = Color3.fromRGB(55, 55, 60),          -- Hover Color
        Border = Color3.fromRGB(60, 60, 65),         -- Border Color
        PrimaryLight = Color3.fromRGB(255, 80, 100), -- Lighter Accent (Crimson Red)

        -- Aliases & Specifics
        TextDark = Color3.fromRGB(220, 220, 220),    -- Alias for new Text
        TextLight = Color3.fromRGB(220, 220, 220),   -- Alias for new Text
        Close = Color3.fromRGB(255, 95, 87),
        Minimize = Color3.fromRGB(255, 189, 46),
        Resize = Color3.fromRGB(40, 200, 64),
        Success = Color3.fromRGB(39, 200, 63),
        SplashBack = Color3.fromRGB(25, 25, 25),
        Shadow = Color3.fromRGB(0, 0, 0),
        Gray = Color3.fromRGB(45, 45, 50),           -- Kept for compatibility
        LightGray = Color3.fromRGB(45, 45, 50)      -- Kept for compatibility
    },
    Fonts = {
        Title = Enum.Font.GothamMedium,
        Body = Enum.Font.Gotham
    },
    Sizes = {
        LargeRadius = UDim.new(0, 8),
        SmallRadius = UDim.new(0, 6),
        FullRadius = UDim.new(1, 0),
        SwitchRadius = UDim.new(0, 4)
    },
    Icons = {
        ["aperture"] = "rbxassetid://7733666258",
        ["bug"] = "rbxassetid://7733701545",
        ["chevrons-down-up"] = "rbxassetid://7733720483",
        ["clock-6"] = "rbxassetid://8997384977",
        ["egg"] = "rbxassetid://8997385940",
        ["external-link"] = "rbxassetid://7743866903",
        ["lightbulb-off"] = "rbxassetid://7733975123",
        ["file-check-2"] = "rbxassetid://7733779610",
        ["settings"] = "rbxassetid://7734053495",
        ["crown"] = "rbxassetid://7733765398",
        ["coins"] = "rbxassetid://7743866529",
        ["battery"] = "rbxassetid://7733674820",
        ["flashlight-off"] = "rbxassetid://7733798799",
        ["camera-off"] = "rbxassetid://7733919260",
        ["function-square"] = "rbxassetid://7733799682",
        ["mountain-snow"] = "rbxassetid://7743870286",
        ["gamepad"] = "rbxassetid://7733799901",
        ["gift"] = "rbxassetid://7733946818",
        ["globe"] = "rbxassetid://7733954760",
        ["option"] = "rbxassetid://7734021300",
        ["hand"] = "rbxassetid://7733955740",
        ["hard-hat"] = "rbxassetid://7733955850",
        ["hash"] = "rbxassetid://7733955906",
        ["server"] = "rbxassetid://7734053426",
        ["align-horizontal-space-around"] = "rbxassetid://8997381738",
        ["highlighter"] = "rbxassetid://7743868648",
        ["bike"] = "rbxassetid://7733678330",
        ["home"] = "rbxassetid://7733960981",
        ["image"] = "rbxassetid://7733964126",
        ["indent"] = "rbxassetid://7733964452",
        ["infinity"] = "rbxassetid://7733964640",
        ["inspect"] = "rbxassetid://7733964808",
        ["alert-triangle"] = "rbxassetid://7733658504",
        ["align-start-horizontal"] = "rbxassetid://8997381965",
        ["figma"] = "rbxassetid://7743867310",
        ["pin"] = "rbxassetid://8997386648",
        ["corner-up-right"] = "rbxassetid://7733764915",
        ["list-x"] = "rbxassetid://7743869517",
        ["monitor-off"] = "rbxassetid://7734000184",
        ["chevron-first"] = "rbxassetid://8997383275",
        ["package-search"] = "rbxassetid://8997386448",
        ["pencil"] = "rbxassetid://7734022107",
        ["cloud-fog"] = "rbxassetid://7733920317",
        ["grip-horizontal"] = "rbxassetid://7733955302",
        ["align-center-vertical"] = "rbxassetid://8997380737",
        ["outdent"] = "rbxassetid://7734021384",
        ["more-vertical"] = "rbxassetid://7734006187",
        ["package-plus"] = "rbxassetid://8997386355",
        ["bluetooth"] = "rbxassetid://7733687147",
        ["pen-tool"] = "rbxassetid://7734022041",
        ["person-standing"] = "rbxassetid://7743871002",
        ["tornado"] = "rbxassetid://7743873633",
        ["phone-incoming"] = "rbxassetid://7743871120",
        ["phone-off"] = "rbxassetid://7734029534",
        ["dribbble"] = "rbxassetid://7733770843",
        ["at-sign"] = "rbxassetid://7733673907",
        ["edit-2"] = "rbxassetid://7733771217",
        ["sheet"] = "rbxassetid://7743871876",
        ["tv"] = "rbxassetid://7743874674",
        ["headphones"] = "rbxassetid://7733956063",
        ["qr-code"] = "rbxassetid://7743871575",
        ["reply"] = "rbxassetid://7734051594",
        ["rewind"] = "rbxassetid://7734051670",
        ["bell-off"] = "rbxassetid://7733675107",
        ["file-check"] = "rbxassetid://7733779668",
        ["quote"] = "rbxassetid://7734045100",
        ["rotate-ccw"] = "rbxassetid://7734051861",
        ["library"] = "rbxassetid://7743869054",
        ["clock-1"] = "rbxassetid://8997383694",
        ["on-charge"] = "rbxassetid://7734021231",
        ["video-off"] = "rbxassetid://7743876466",
        ["save"] = "rbxassetid://7734052335",
        ["arrow-left-circle"] = "rbxassetid://7733673056",
        ["screen-share"] = "rbxassetid://7734052814",
        ["clock-3"] = "rbxassetid://8997384456",
        ["help-circle"] = "rbxassetid://7733956210",
        ["server-crash"] = "rbxassetid://7734053281",
        ["bluetooth-searching"] = "rbxassetid://7733914320",
        ["equal"] = "rbxassetid://7733771811",
        ["shield-close"] = "rbxassetid://7734056470",
        ["phone"] = "rbxassetid://7734032056",
        ["type"] = "rbxassetid://7743874740",
        ["file-x-2"] = "rbxassetid://7743867554",
        ["sidebar"] = "rbxassetid://7734058260",
        ["sigma"] = "rbxassetid://7734058345",
        ["smartphone-charging"] = "rbxassetid://7734058894",
        ["arrow-left"] = "rbxassetid://7733673136",
        ["framer"] = "rbxassetid://7733799486",
        ["currency"] = "rbxassetid://7733765592",
        ["star"] = "rbxassetid://7734068321",
        ["stretch-horizontal"] = "rbxassetid://8997387754",
        ["smile"] = "rbxassetid://7734059095",
        ["subscript"] = "rbxassetid://8997387937",
        ["sun"] = "rbxassetid://7734068495",
        ["switch-camera"] = "rbxassetid://7743872492",
        ["table"] = "rbxassetid://7734073253",
        ["tag"] = "rbxassetid://7734075797",
        ["cross"] = "rbxassetid://7733765224",
        ["gem"] = "rbxassetid://7733942651",
        ["link"] = "rbxassetid://7733978098",
        ["terminal"] = "rbxassetid://7743872929",
        ["thermometer-sun"] = "rbxassetid://7734084018",
        ["share-2"] = "rbxassetid://7734053595",
        ["timer-off"] = "rbxassetid://8997388325",
        ["megaphone"] = "rbxassetid://7733993049",
        ["timer-reset"] = "rbxassetid://7743873336",
        ["phone-forwarded"] = "rbxassetid://7734027345",
        ["unlock"] = "rbxassetid://7743875263",
        ["trello"] = "rbxassetid://7743873996",
        ["camera"] = "rbxassetid://7733708692",
        ["triangle"] = "rbxassetid://7743874367",
        ["truck"] = "rbxassetid://7743874482",
        ["file-output"] = "rbxassetid://7733788742",
        ["gamepad-2"] = "rbxassetid://7733799795",
        ["network"] = "rbxassetid://7734021047",
        ["users"] = "rbxassetid://7743876054",
        ["electricity-off"] = "rbxassetid://7733771563",
        ["book"] = "rbxassetid://7733914390",
        ["clock-9"] = "rbxassetid://8997385485",
        ["corner-down-left"] = "rbxassetid://7733764327",
        ["locate-fixed"] = "rbxassetid://7733992424",
        ["bar-chart"] = "rbxassetid://7733674319",
        ["shield-check"] = "rbxassetid://7734056411",
        ["signal-low"] = "rbxassetid://8997387189",
        ["reply-all"] = "rbxassetid://7734051524",
        ["zoom-in"] = "rbxassetid://7743878977",
        ["grip-vertical"] = "rbxassetid://7733955410",
        ["ticket"] = "rbxassetid://7734086558",
        ["smartphone"] = "rbxassetid://7734058979",
        ["arrow-big-right"] = "rbxassetid://7733671493",
        ["tv-2"] = "rbxassetid://7743874599",
        ["flashlight"] = "rbxassetid://7733798851",
        ["database"] = "rbxassetid://7743866778",
        ["plus-square"] = "rbxassetid://7734040369",
        ["align-justify"] = "rbxassetid://7733661326",
        ["clipboard-list"] = "rbxassetid://7733920117",
        ["github"] = "rbxassetid://7733954058",
        ["columns"] = "rbxassetid://7733757178",
        ["arrow-big-down"] = "rbxassetid://7733668653",
        ["cloud-off"] = "rbxassetid://7733745572",
        ["target"] = "rbxassetid://7743872758",
        ["skip-back"] = "rbxassetid://7734058404",
        ["x-circle"] = "rbxassetid://7743878496",
        ["clock-10"] = "rbxassetid://8997383876",
        ["align-right"] = "rbxassetid://7733663582",
        ["clock-5"] = "rbxassetid://8997384798",
        ["bell-plus"] = "rbxassetid://7733675181",
        ["battery-medium"] = "rbxassetid://7733674731",
        ["arrow-down"] = "rbxassetid://7733672933",
        ["inbox"] = "rbxassetid://7733964370",
        ["cast"] = "rbxassetid://7733919326",
        ["gift-card"] = "rbxassetid://7733945018",
        ["webcam"] = "rbxassetid://7743877896",
        ["folder-minus"] = "rbxassetid://7733799022",
        ["scan-line"] = "rbxassetid://8997386772",
        ["shovel"] = "rbxassetid://7734056878",
        ["download-cloud"] = "rbxassetid://7733770689",
        ["list-checks"] = "rbxassetid://7743869317",
        ["file-text"] = "rbxassetid://7733789088",
        ["codesandbox"] = "rbxassetid://7733752575",
        ["laptop-2"] = "rbxassetid://7733965313",
        ["podcast"] = "rbxassetid://7734042234",
        ["log-out"] = "rbxassetid://7733992677",
        ["thumbs-up"] = "rbxassetid://7743873212",
        ["timer"] = "rbxassetid://7743873443",
        ["text-cursor"] = "rbxassetid://8997388195",
        ["file-search"] = "rbxassetid://7733788966",
        ["thermometer"] = "rbxassetid://7734084149",
        ["bluetooth-off"] = "rbxassetid://7733914252",
        ["refresh-cw"] = "rbxassetid://7734051052",
        ["clipboard-check"] = "rbxassetid://7733919947",
        ["languages"] = "rbxassetid://7733965249",
        ["asterisk"] = "rbxassetid://7733673800",
        ["superscript"] = "rbxassetid://8997388036",
        ["user-check"] = "rbxassetid://7743875503",
        ["move-diagonal"] = "rbxassetid://7743870505",
        ["copy"] = "rbxassetid://7733764083",
        ["bot"] = "rbxassetid://7733916988",
        ["alarm-minus"] = "rbxassetid://7733656164",
        ["log-in"] = "rbxassetid://7733992604",
        ["maximize"] = "rbxassetid://7733992982",
        ["align-horizontal-space-between"] = "rbxassetid://8997381854",
        ["brush"] = "rbxassetid://7733701455",
        ["equal-not"] = "rbxassetid://7733771726",
        ["upload"] = "rbxassetid://7743875428",
        ["minus-circle"] = "rbxassetid://7733998053",
        ["graduation-cap"] = "rbxassetid://7733955058",
        ["edit-3"] = "rbxassetid://7733771361",
        ["check"] = "rbxassetid://7733715400",
        ["scissors"] = "rbxassetid://7734052570",
        ["info"] = "rbxassetid://7733964719",
        ["align-horizonal-distribute-start"] = "rbxassetid://8997381290",
        ["book-open"] = "rbxassetid://7733687281",
        ["divide-circle"] = "rbxassetid://7733769152",
        ["file"] = "rbxassetid://7733793319",
        ["clock-2"] = "rbxassetid://8997384295",
        ["corner-right-up"] = "rbxassetid://7733764680",
        ["clover"] = "rbxassetid://7733747233",
        ["expand"] = "rbxassetid://7733771982",
        ["gauge"] = "rbxassetid://7733799969",
        ["phone-outgoing"] = "rbxassetid://7743871253",
        ["shield-alert"] = "rbxassetid://7734056326",
        ["paperclip"] = "rbxassetid://7734021680",
        ["arrow-big-left"] = "rbxassetid://7733911731",
        ["album"] = "rbxassetid://7733658133",
        ["bookmark"] = "rbxassetid://7733692043",
        ["check-circle-2"] = "rbxassetid://7733710700",
        ["list-ordered"] = "rbxassetid://7743869411",
        ["delete"] = "rbxassetid://7733768142",
        ["axe"] = "rbxassetid://7733674079",
        ["radio"] = "rbxassetid://7743871662",
        ["octagon"] = "rbxassetid://7734021165",
        ["git-commit"] = "rbxassetid://7743868360",
        ["shirt"] = "rbxassetid://7734056672",
        ["corner-right-down"] = "rbxassetid://7733764605",
        ["trending-down"] = "rbxassetid://7743874143",
        ["airplay"] = "rbxassetid://7733655834",
        ["repeat"] = "rbxassetid://7734051454",
        ["layers"] = "rbxassetid://7743868936",
        ["chevron-right"] = "rbxassetid://7733717755",
        ["chevrons-right"] = "rbxassetid://7733919682",
        ["folder-plus"] = "rbxassetid://7733799092",
        ["alarm-check"] = "rbxassetid://7733655912",
        ["arrow-up-right"] = "rbxassetid://7733673646",
        ["user-plus"] = "rbxassetid://7743875759",
        ["file-minus"] = "rbxassetid://7733936115",
        ["cloud-drizzle"] = "rbxassetid://7733920226",
        ["stretch-vertical"] = "rbxassetid://8997387862",
        ["align-vertical-distribute-start"] = "rbxassetid://8997382428",
        ["unlink"] = "rbxassetid://7743875149",
        ["wand"] = "rbxassetid://8997388430",
        ["regex"] = "rbxassetid://7734051188",
        ["command"] = "rbxassetid://7733924046",
        ["haze"] = "rbxassetid://7733955969",
        ["trash"] = "rbxassetid://7743873871",
        ["battery-full"] = "rbxassetid://7733674503",
        ["flag-triangle-left"] = "rbxassetid://7733798509",
        ["server-off"] = "rbxassetid://7734053361",
        ["loader-2"] = "rbxassetid://7733989869",
        ["monitor-speaker"] = "rbxassetid://7743869988",
        ["shuffle"] = "rbxassetid://7734057059",
        ["tablet"] = "rbxassetid://7743872620",
        ["cloud-moon"] = "rbxassetid://7733920519",
        ["clipboard-x"] = "rbxassetid://7733734668",
        ["pocket"] = "rbxassetid://7734042139",
        ["watch"] = "rbxassetid://7743877668",
        ["file-plus"] = "rbxassetid://7733788885",
        ["locate"] = "rbxassetid://7733992469",
        ["share"] = "rbxassetid://7734053697",
        ["thermometer-snowflake"] = "rbxassetid://7743873074",
        ["volume-1"] = "rbxassetid://7743877081",
        ["arrow-left-right"] = "rbxassetid://8997382869",
        ["coffee"] = "rbxassetid://7733752630",
        ["chevron-last"] = "rbxassetid://8997383390",
        ["cloud-hail"] = "rbxassetid://7733920444",
        ["alarm-clock-off"] = "rbxassetid://7733656003",
        ["pound-sterling"] = "rbxassetid://7734042354",
        ["tent"] = "rbxassetid://7734078943",
        ["toggle-left"] = "rbxassetid://7734091286",
        ["dollar-sign"] = "rbxassetid://7733770599",
        ["sunrise"] = "rbxassetid://7743872365",
        ["sunset"] = "rbxassetid://7734070982",
        ["code"] = "rbxassetid://7733749837",
        ["thumbs-down"] = "rbxassetid://7734084236",
        ["trending-up"] = "rbxassetid://7743874262",
        ["clock-12"] = "rbxassetid://8997384150",
        ["rocking-chair"] = "rbxassetid://7734051769",
        ["check-square"] = "rbxassetid://7733919526",
        ["cpu"] = "rbxassetid://7733765045",
        ["palette"] = "rbxassetid://7734021595",
        ["minimize-2"] = "rbxassetid://7733997870",
        ["cloud-sun"] = "rbxassetid://7733746880",
        ["copyleft"] = "rbxassetid://7733764196",
        ["archive"] = "rbxassetid://7733911621",
        ["building"] = "rbxassetid://7733701625",
        ["image-minus"] = "rbxassetid://7733963797",
        ["italic"] = "rbxassetid://7733964917",
        ["link-2-off"] = "rbxassetid://7733975283",
        ["sort-asc"] = "rbxassetid://7734060715",
        ["underline"] = "rbxassetid://7743874904",
        ["gitlab"] = "rbxassetid://7733954246",
        ["file-minus-2"] = "rbxassetid://7733936010",
        ["play-circle"] = "rbxassetid://7734037784",
        ["clock-8"] = "rbxassetid://8997385352",
        ["file-input"] = "rbxassetid://7733935917",
        ["beaker"] = "rbxassetid://7733674922",
        ["shopping-bag"] = "rbxassetid://7734056747",
        ["navigation"] = "rbxassetid://7734020989",
        ["moon"] = "rbxassetid://7743870134",
        ["align-vertical-space-between"] = "rbxassetid://8997382793",
        ["glasses"] = "rbxassetid://7733954403",
        ["clipboard-copy"] = "rbxassetid://7733920037",
        ["feather"] = "rbxassetid://7733777166",
        ["skip-forward"] = "rbxassetid://7734058495",
        ["wind"] = "rbxassetid://7743878264",
        ["frown"] = "rbxassetid://7733799591",
        ["move-vertical"] = "rbxassetid://7743870608",
        ["umbrella"] = "rbxassetid://7743874820",
        ["package"] = "rbxassetid://7734021469",
        ["chevrons-up"] = "rbxassetid://7733723433",
        ["download"] = "rbxassetid://7733770755",
        ["eye"] = "rbxassetid://7733774602",
        ["files"] = "rbxassetid://7743867811",
        ["arrow-down-right"] = "rbxassetid://7733672831",
        ["code-2"] = "rbxassetid://7733920644",
        ["wrap-text"] = "rbxassetid://8997388548",
        ["file-digit"] = "rbxassetid://7733935829",
        ["x-square"] = "rbxassetid://7743878737",
        ["clipboard"] = "rbxassetid://7733734762",
        ["maximize-2"] = "rbxassetid://7733992901",
        ["send"] = "rbxassetid://7734053039",
        ["alarm-clock"] = "rbxassetid://7733656100",
        ["sliders"] = "rbxassetid://7734058803",
        ["refresh-ccw"] = "rbxassetid://7734050715",
        ["music"] = "rbxassetid://7734020554",
        ["banknote"] = "rbxassetid://7733674153",
        ["hard-drive"] = "rbxassetid://7733955793",
        ["search"] = "rbxassetid://7734052925",
        ["layout-list"] = "rbxassetid://7733970442",
        ["edit"] = "rbxassetid://7733771472",
        ["contrast"] = "rbxassetid://7733764005",
        ["wifi"] = "rbxassetid://7743878148",
        ["swiss-franc"] = "rbxassetid://7734071038",
        ["ghost"] = "rbxassetid://7743868000",
        ["laptop"] = "rbxassetid://7733965386",
        ["clock-4"] = "rbxassetid://8997384603",
        ["layout-dashboard"] = "rbxassetid://7733970318",
        ["align-vertical-justify-end"] = "rbxassetid://8997382584",
        ["circle"] = "rbxassetid://7733919881",
        ["file-x"] = "rbxassetid://7733938136",
        ["award"] = "rbxassetid://7733673987",
        ["corner-left-down"] = "rbxassetid://7733764448",
        ["arrow-up-left"] = "rbxassetid://7733673539",
        ["carrot"] = "rbxassetid://8997382987",
        ["globe-2"] = "rbxassetid://7733954611",
        ["compass"] = "rbxassetid://7733924216",
        ["git-branch"] = "rbxassetid://7733949149",
        ["vibrate"] = "rbxassetid://7743876302",
        ["pause-circle"] = "rbxassetid://7734021767",
        ["minus-square"] = "rbxassetid://7743869899",
        ["mic-off"] = "rbxassetid://7743869714",
        ["arrow-down-circle"] = "rbxassetid://7733671763",
        ["move-horizontal"] = "rbxassetid://7743870608",
        ["chrome"] = "rbxassetid://7733919783",
        ["radio-receiver"] = "rbxassetid://7734045155",
        ["shield"] = "rbxassetid://7734056608",
        ["image-plus"] = "rbxassetid://7733964016",
        ["more-horizontal"] = "rbxassetid://7734006080",
        ["slash"] = "rbxassetid://8997387644",
        ["divide"] = "rbxassetid://7733769365",
        ["view"] = "rbxassetid://7743876754",
        ["list"] = "rbxassetid://7743869612",
        ["printer"] = "rbxassetid://7734042580",
        ["corner-left-up"] = "rbxassetid://7733764536",
        ["meh"] = "rbxassetid://7733993147",
        ["copyright"] = "rbxassetid://7733764275",
        ["align-end-vertical"] = "rbxassetid://8997380907",
        ["heart"] = "rbxassetid://7733956134",
        ["lock"] = "rbxassetid://7733992528",
        ["align-center"] = "rbxassetid://7733909776",
        ["signal-high"] = "rbxassetid://8997387110",
        ["upload-cloud"] = "rbxassetid://7743875358",
        ["arrow-up-circle"] = "rbxassetid://7733673466",
        ["git-branch-plus"] = "rbxassetid://7743868200",
        ["align-vertical-justify-center"] = "rbxassetid://8997382502",
        ["screen-share-off"] = "rbxassetid://7734052653",
        ["git-pull-request"] = "rbxassetid://7733952287",
        ["flag"] = "rbxassetid://7733798691",
        ["star-half"] = "rbxassetid://7734068258",
        ["minus"] = "rbxassetid://7734000129",
        ["mountain"] = "rbxassetid://7734008868",
        ["volume"] = "rbxassetid://7743877487",
        ["mouse-pointer-2"] = "rbxassetid://7734010405",
        ["package-x"] = "rbxassetid://8997386545",
        ["indian-rupee"] = "rbxassetid://7733964536",
        ["speaker"] = "rbxassetid://7734063416",
        ["flame"] = "rbxassetid://7733798747",
        ["circle-slashed"] = "rbxassetid://8997383530",
        ["crop"] = "rbxassetid://7733765140",
        ["clock-11"] = "rbxassetid://8997384034",
        ["stop-circle"] = "rbxassetid://7734068379",
        ["align-horizontal-justify-end"] = "rbxassetid://8997381549",
        ["power-off"] = "rbxassetid://7734042423",
        ["bell-minus"] = "rbxassetid://7733675028",
        ["undo"] = "rbxassetid://7743874974",
        ["link-2"] = "rbxassetid://7743869163",
        ["lightbulb"] = "rbxassetid://7733975185",
        ["shrink"] = "rbxassetid://7734056971",
        ["mail"] = "rbxassetid://7733992732",
        ["pause"] = "rbxassetid://7734021897",
        ["bold"] = "rbxassetid://7733687211",
        ["calendar"] = "rbxassetid://7733919198",
        ["x-octagon"] = "rbxassetid://7743878618",
        ["russian-ruble"] = "rbxassetid://7734052248",
        ["file-code"] = "rbxassetid://7733779730",
        ["life-buoy"] = "rbxassetid://7733973479",
        ["import"] = "rbxassetid://7733964240",
        ["video"] = "rbxassetid://7743876610",
        ["clock-7"] = "rbxassetid://8997385147",
        ["align-center-horizontal"] = "rbxassetid://8997380477",
        ["bell"] = "rbxassetid://7733911828",
        ["move-diagonal-2"] = "rbxassetid://7734013178",
        ["message-circle"] = "rbxassetid://7733993311",
        ["skull"] = "rbxassetid://7734058599",
        ["battery-charging"] = "rbxassetid://7733674402",
        ["ruler"] = "rbxassetid://7734052157",
        ["binary"] = "rbxassetid://7733678388",
        ["cloud-rain-wind"] = "rbxassetid://7733746456",
        ["briefcase"] = "rbxassetid://7733919017",
        ["terminal-square"] = "rbxassetid://7734079055",
        ["scale"] = "rbxassetid://7734052454",
        ["lasso"] = "rbxassetid://7733967892",
        ["piggy-bank"] = "rbxassetid://7734034513",
        ["battery-low"] = "rbxassetid://7733674589",
        ["arrow-up"] = "rbxassetid://7733673717",
        ["list-plus"] = "rbxassetid://7733984995",
        ["bookmark-plus"] = "rbxassetid://7734111084",
        ["box-select"] = "rbxassetid://7733696665",
        ["filter"] = "rbxassetid://7733798407",
        ["play"] = "rbxassetid://7743871480",
        ["align-vertical-space-around"] = "rbxassetid://8997382708",
        ["calculator"] = "rbxassetid://7733919105",
        ["bell-ring"] = "rbxassetid://7733675275",
        ["plane"] = "rbxassetid://7734037723",
        ["plus-circle"] = "rbxassetid://7734040271",
        ["power"] = "rbxassetid://7734042493",
        ["phone-missed"] = "rbxassetid://7734029465",
        ["percent"] = "rbxassetid://7743870852",
        ["jersey-pound"] = "rbxassetid://7733965029",
        ["mouse-pointer"] = "rbxassetid://7743870392",
        ["box"] = "rbxassetid://7733917120",
        ["separator-vertical"] = "rbxassetid://7734053213",
        ["snowflake"] = "rbxassetid://7734059180",
        ["sort-desc"] = "rbxassetid://7743871973",
        ["flag-triangle-right"] = "rbxassetid://7733798634",
        ["bar-chart-2"] = "rbxassetid://7733674239",
        ["hand-metal"] = "rbxassetid://7733955664",
        ["map"] = "rbxassetid://7733992829",
        ["eye-off"] = "rbxassetid://7733774495",
        ["align-end-horizontal"] = "rbxassetid://8997380820",
        ["cloud-rain"] = "rbxassetid://7733746651",
        ["contact"] = "rbxassetid://7743866666",
        ["signal"] = "rbxassetid://8997387546",
        ["mouse-pointer-click"] = "rbxassetid://7734010488",
        ["settings-2"] = "rbxassetid://8997386997",
        ["sidebar-open"] = "rbxassetid://7734058165",
        ["unlink-2"] = "rbxassetid://7743875069",
        ["pause-octagon"] = "rbxassetid://7734021827",
        ["user-minus"] = "rbxassetid://7743875629",
        ["cloud"] = "rbxassetid://7733746980",
        ["arrow-right-circle"] = "rbxassetid://7733673229",
        ["align-horizonal-distribute-center"] = "rbxassetid://8997381028",
        ["fast-forward"] = "rbxassetid://7743867090",
        ["volume-2"] = "rbxassetid://7743877250",
        ["grab"] = "rbxassetid://7733954884",
        ["arrow-right"] = "rbxassetid://7733673345",
        ["chevron-down"] = "rbxassetid://7733717447",
        ["volume-x"] = "rbxassetid://7743877381",
        ["cloud-snow"] = "rbxassetid://7733746798",
        ["car"] = "rbxassetid://7733708835",
        ["bluetooth-connected"] = "rbxassetid://7734110952",
        ["CD"] = "rbxassetid://7734110220",
        ["cookie"] = "rbxassetid://8997385628",
        ["message-square"] = "rbxassetid://7733993369",
        ["repeat-1"] = "rbxassetid://7734051342",
        ["codepen"] = "rbxassetid://7733920768",
        ["voicemail"] = "rbxassetid://7743876916",
        ["text-cursor-input"] = "rbxassetid://8997388094",
        ["package-check"] = "rbxassetid://8997386143",
        ["shopping-cart"] = "rbxassetid://7734056813",
        ["corner-down-right"] = "rbxassetid://7733764385",
        ["folder-open"] = "rbxassetid://8997386062",
        ["charge"] = "rbxassetid://8997383136",
        ["layout-grid"] = "rbxassetid://7733970390",
        ["clock"] = "rbxassetid://7733734848",
        ["corner-up-left"] = "rbxassetid://7733764800",
        ["align-horizontal-justify-start"] = "rbxassetid://8997381652",
        ["git-merge"] = "rbxassetid://7733952195",
        ["verified"] = "rbxassetid://7743876142",
        ["redo"] = "rbxassetid://7743871739",
        ["hexagon"] = "rbxassetid://7743868527",
        ["square"] = "rbxassetid://7743872181",
        ["align-horizontal-justify-center"] = "rbxassetid://8997381461",
        ["chevrons-up-down"] = "rbxassetid://7733723321",
        ["bus"] = "rbxassetid://7733701715",
        ["file-plus-2"] = "rbxassetid://7733788816",
        ["alarm-plus"] = "rbxassetid://7733658066",
        ["divide-square"] = "rbxassetid://7733769261",
        ["pie-chart"] = "rbxassetid://7734034378",
        ["signal-zero"] = "rbxassetid://8997387434",
        ["hammer"] = "rbxassetid://7733955511",
        ["history"] = "rbxassetid://7733960880",
        ["align-vertical-justify-start"] = "rbxassetid://8997382639",
        ["flask-round"] = "rbxassetid://7733798957",
        ["wifi-off"] = "rbxassetid://7743878056",
        ["zoom-out"] = "rbxassetid://7743879082",
        ["toggle-right"] = "rbxassetid://7743873539",
        ["monitor"] = "rbxassetid://7734002839",
        ["x"] = "rbxassetid://7743878857",
        ["align-horizonal-distribute-end"] = "rbxassetid://8997381144",
        ["user"] = "rbxassetid://7743875962",
        ["sprout"] = "rbxassetid://7743872071",
        ["move"] = "rbxassetid://7743870731",
        ["gavel"] = "rbxassetid://7733800044",
        ["package-minus"] = "rbxassetid://8997386266",
        ["drumstick"] = "rbxassetid://8997385789",
        ["forward"] = "rbxassetid://7733799371",
        ["sidebar-close"] = "rbxassetid://7734058092",
        ["electricity"] = "rbxassetid://7733771628",
        ["plus"] = "rbxassetid://7734042071",
        ["pipette"] = "rbxassetid://7743871384",
        ["cloud-lightning"] = "rbxassetid://7733741741",
        ["lasso-select"] = "rbxassetid://7743868832",
        ["phone-call"] = "rbxassetid://7734027264",
        ["droplet"] = "rbxassetid://7733770982",
        ["key"] = "rbxassetid://7733965118",
        ["map-pin"] = "rbxassetid://7733992789",
        ["navigation-2"] = "rbxassetid://7734020942",
        ["list-minus"] = "rbxassetid://7733980795",
        ["chevron-up"] = "rbxassetid://7733919605",
        ["layout-template"] = "rbxassetid://7733970494",
        ["no_entry"] = "rbxassetid://7734021118",
        ["scan"] = "rbxassetid://8997386861",
        ["arrow-big-up"] = "rbxassetid://7733671663",
        ["bookmark-minus"] = "rbxassetid://7733689754",
        ["activity"] = "rbxassetid://7733655755",
        ["grid"] = "rbxassetid://7733955179",
        ["user-x"] = "rbxassetid://7743875879",
        ["alert-circle"] = "rbxassetid://7733658271",
        ["menu"] = "rbxassetid://7733993211",
        ["form-input"] = "rbxassetid://7733799275",
        ["rss"] = "rbxassetid://7734052075",
        ["loader"] = "rbxassetid://7733992358",
        ["align-vertical-distribute-end"] = "rbxassetid://8997382326",
        ["strikethrough"] = "rbxassetid://7734068425",
        ["mic"] = "rbxassetid://7743869805",
        ["landmark"] = "rbxassetid://7733965184",
        ["crosshair"] = "rbxassetid://7733765307",
        ["alert-octagon"] = "rbxassetid://7733658335",
        ["anchor"] = "rbxassetid://7733911490",
        ["separator-horizontal"] = "rbxassetid://7734053146",
        ["chevron-left"] = "rbxassetid://7733717651",
        ["flask-conical"] = "rbxassetid://7733798901",
        ["wallet"] = "rbxassetid://7743877573",
        ["euro"] = "rbxassetid://7733771891",
        ["trash-2"] = "rbxassetid://7743873772",
        ["check-circle"] = "rbxassetid://7733919427",
        ["layout"] = "rbxassetid://7733970543",
        ["droplets"] = "rbxassetid://7733771078",
        ["align-start-vertical"] = "rbxassetid://8997382085",
        ["rotate-cw"] = "rbxassetid://7734051957",
        ["minimize"] = "rbxassetid://7733997941",
        ["arrow-down-left"] = "rbxassetid://7733672282",
        ["signal-medium"] = "rbxassetid://8997387319",
        ["align-vertical-distribute-center"] = "rbxassetid://8997382212",
        ["image-off"] = "rbxassetid://7733963907",
        ["cloudy"] = "rbxassetid://7733747106",
        ["align-left"] = "rbxassetid://7733911357",
        ["film"] = "rbxassetid://7733942579",
        ["chevrons-down"] = "rbxassetid://7733720604",
        ["pointer"] = "rbxassetid://7734042307",
        ["folder"] = "rbxassetid://7733799185",
        ["chevrons-left"] = "rbxassetid://7733720701",
        ["shield-off"] = "rbxassetid://7734056540",
        ["wrench"] = "rbxassetid://7743878358"
    }
}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")


local lib = {}
local sections = {}
local workareas = {}
local sectionAPIs = {}
local notifs = {}
local visible = false
local dbcooper = false

local function tp(ins, pos, time)
    TweenService:Create(ins, TweenInfo.new(time, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {Position = pos}):Play()
end

local function createGradient(parent, color1, color2)
    local grad = Instance.new("UIGradient", parent)
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color1),
        ColorSequenceKeypoint.new(1, color2)
    })
    grad.Rotation = 90
    return grad
end

function lib:init(ti, sub_ti, dosplash, visiblekey, deleteprevious)
    local scrgui
    local sidebar
    local search
    local logo
    local window = {}
    local notifdarkness, notif2darkness
    local activeWorkarea = nil

    local isMobile = UserInputService.TouchEnabled
    local minSize = isMobile and Vector2.new(650, 400) or Vector2.new(850, 600)
    local defaultSize = isMobile and Vector2.new(650, 400) or Vector2.new(850, 600)
    
    local isMaximized = false
    local originalSize
    local originalPosition

    if syn then
        if CoreGui:FindFirstChild("AegisLib") and deleteprevious then
            if CoreGui.AegisLib:FindFirstChild("main") then
                tp(CoreGui.AegisLib.main, CoreGui.AegisLib.main.Position + UDim2.new(0, 0, 2, 0), 0.5)
            end
            Debris:AddItem(CoreGui.AegisLib, 1)
        end
        scrgui = Instance.new("ScreenGui")
        scrgui.Name = "AegisLib"
        
        syn.protect_gui(scrgui)
        scrgui.Parent = CoreGui
    elseif gethui then
        local hui = gethui()
        if hui:FindFirstChild("AegisLib") and deleteprevious then
            if hui.AegisLib:FindFirstChild("main") then
                hui.AegisLib.main:TweenPosition(hui.AegisLib.main.Position + UDim2.new(0, 0, 2, 0), "InOut", "Quart", 0.5)
            end
            Debris:AddItem(hui.AegisLib, 1)
        end
        scrgui = Instance.new("ScreenGui")
        scrgui.Name = "AegisLib"
        scrgui.Parent = hui
    else
        if CoreGui:FindFirstChild("AegisLib") and deleteprevious then
            if CoreGui.AegisLib:FindFirstChild("main") then
                tp(CoreGui.AegisLib.main, CoreGui.AegisLib.main.Position + UDim2.new(0, 0, 2, 0), 0.5)
            end
            Debris:AddItem(CoreGui.AegisLib, 1)
        end
        scrgui = Instance.new("ScreenGui")
        scrgui.Name = "AegisLib"
        scrgui.Parent = CoreGui
    end

    local loadingScreen
    local progressBar
    local function updateLoadingProgress(statusText, progress)
        if loadingScreen and loadingScreen:FindFirstChild("Status") then
            loadingScreen.Status.Text = statusText
        end
        if progressBar then
            local tween = TweenService:Create(progressBar, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(progress, 0, 1, 0)})
            tween:Play()
        end
    end

    if dosplash then
        local blur = Instance.new("BlurEffect")
        blur.Name = "MacOsLibBlur"
        blur.Parent = game:GetService("Lighting")
        blur.Size = 0
        blur.Enabled = true
        TweenService:Create(blur, TweenInfo.new(0.5), {Size = 16}):Play()

        local statusLabel

        loadingScreen = Instance.new("Frame")
        loadingScreen.Name = "LoadingScreen"
        loadingScreen.Parent = scrgui
        loadingScreen.AnchorPoint = Vector2.new(0.5, 0.5) 
        loadingScreen.BackgroundColor3 = Theme.Colors.SplashBack
        loadingScreen.BackgroundTransparency = 1
        loadingScreen.Position = UDim2.new(0.5, 0, 0.5, 0) 
        loadingScreen.Size = UDim2.new(0, 400, 0, 250)
        loadingScreen.ZIndex = 1000
        
        local corner = Instance.new("UICorner", loadingScreen)
        corner.CornerRadius = Theme.Sizes.SmallRadius

        local logo = Instance.new("ImageLabel", loadingScreen)
        logo.Size = UDim2.new(0, 400, 0, 350)
        logo.Position = UDim2.new(0.5, 0, 0.4, 0)
        logo.AnchorPoint = Vector2.new(0.5, 0.5)
        logo.BackgroundTransparency = 1
        logo.Image = "rbxassetid://101129417614969"
        logo.ZIndex = 1001
        logo.ScaleType = Enum.ScaleType.Fit

        statusLabel = Instance.new("TextLabel", loadingScreen)
        statusLabel.Name = "Status"
        statusLabel.Size = UDim2.new(1, -20, 0, 30)
        statusLabel.Position = UDim2.new(0.5, 0, 0.8, 0)
        statusLabel.AnchorPoint = Vector2.new(0.5, 0)
        statusLabel.BackgroundTransparency = 1
        statusLabel.Font = Enum.Font.SourceSans
        statusLabel.Text = "Initializing..."
        statusLabel.TextColor3 = Theme.Colors.TextLight
        statusLabel.TextSize = 16
        statusLabel.ZIndex = 1001

        local progressBarTrack = Instance.new("Frame", loadingScreen)
        progressBarTrack.Size = UDim2.new(0.8, 0, 0, 8)
        progressBarTrack.Position = UDim2.new(0.5, 0, 0.95, 0)
        progressBarTrack.AnchorPoint = Vector2.new(0.5, 1)
        progressBarTrack.BackgroundColor3 = Theme.Colors.Gray
        progressBarTrack.ZIndex = 1001

        local uc_progress_track = Instance.new("UICorner", progressBarTrack)
        uc_progress_track.CornerRadius = Theme.Sizes.FullRadius

        progressBar = Instance.new("Frame", progressBarTrack)
        progressBar.Size = UDim2.new(0, 0, 1, 0)
        progressBar.BackgroundColor3 = Theme.Colors.Primary
        progressBar.ZIndex = 1002
        
        createGradient(progressBar, Theme.Colors.Primary, Theme.Colors.PrimaryLight)

        local uc_progress_bar = Instance.new("UICorner", progressBar)
        uc_progress_bar.CornerRadius = Theme.Sizes.FullRadius

        loadingScreen.Position = UDim2.new(0.5, 0, -0.5, 0)
        tp(loadingScreen, UDim2.new(0.5, 0, 0.5, 0), 0.5)
        task.wait(0.5)
    end

    updateLoadingProgress("Creating main window...", 0.25)
    task.wait(1)

    local main = Instance.new("CanvasGroup")
    main.Name = "main"
    main.Parent = scrgui
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.BackgroundColor3 = Theme.Colors.MainBack
    main.BackgroundTransparency = 0.01
    main.Position = UDim2.new(0.5, 0, 2, 0)
    main.Size = UDim2.new(0, defaultSize.X, 0, defaultSize.Y)
    main.ClipsDescendants = true
    main.Active = true 

    local uc = Instance.new("UICorner")
    uc.CornerRadius = Theme.Sizes.LargeRadius
    uc.Parent = main

    local mainShadow = Instance.new("ImageLabel")
    mainShadow.Name = "mainShadow"
    mainShadow.Parent = scrgui
    mainShadow.AnchorPoint = main.AnchorPoint
    mainShadow.BackgroundTransparency = 1
    mainShadow.Position = main.Position
    mainShadow.Size = main.Size
    mainShadow.ZIndex = main.ZIndex - 1
    mainShadow.Image = "rbxassetid://313486536"
    mainShadow.ImageColor3 = Theme.Colors.Shadow
    mainShadow.ImageTransparency = 0.5
    mainShadow.ScaleType = Enum.ScaleType.Slice
    mainShadow.SliceCenter = Rect.new(100, 100, 100, 100)

    local mainShadowCorner = Instance.new("UICorner")
    mainShadowCorner.CornerRadius = Theme.Sizes.LargeRadius
    mainShadowCorner.Parent = mainShadow

    main:GetPropertyChangedSignal("Position"):Connect(function()
        mainShadow.Position = main.Position
    end)

    main:GetPropertyChangedSignal("Size"):Connect(function()
        mainShadow.Size = main.Size
    end)

    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Parent = main
    TopBar.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    TopBar.BorderSizePixel = 0
    TopBar.Size = UDim2.new(1, 0, 0, 30)
    TopBar.ZIndex = 15

    local topbarCorner = Instance.new("UICorner")
    topbarCorner.CornerRadius = Theme.Sizes.LargeRadius
    topbarCorner.Parent = TopBar

    local topbarFiller = Instance.new("Frame")
    topbarFiller.Name = "Filler"
    topbarFiller.Parent = TopBar
    topbarFiller.BackgroundColor3 = TopBar.BackgroundColor3
    topbarFiller.BorderSizePixel = 0
    topbarFiller.Size = UDim2.new(1, 0, 0.5, 0)
    topbarFiller.Position = UDim2.new(0, 0, 0.5, 0)
    topbarFiller.ZIndex = 15

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Parent = TopBar
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.Font = Theme.Fonts.Title
    titleLabel.Text = (ti or "UI Library") .. "   " .. (sub_ti or "User Interface")
    titleLabel.TextColor3 = Theme.Colors.Text
    titleLabel.TextSize = 14
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.ZIndex = 16

    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = main.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    local SettingsBtn = Instance.new("ImageButton")
    SettingsBtn.Name = "Settings"
    SettingsBtn.Parent = TopBar
    SettingsBtn.BackgroundTransparency = 1
    SettingsBtn.Position = UDim2.new(1, -10, 0.5, 0)
    SettingsBtn.AnchorPoint = Vector2.new(1, 0.5)
    SettingsBtn.Size = UDim2.new(0, 20, 0, 20)
    SettingsBtn.Image = Theme.Icons["settings"]
    SettingsBtn.ImageColor3 = Theme.Colors.Text
    SettingsBtn.ZIndex = 17
    
    local settingsClickCallback
    SettingsBtn.MouseButton1Click:Connect(function()
        if settingsClickCallback then
            settingsClickCallback()
        end
    end)
    
    local mainStroke = Instance.new("UIStroke")
    mainStroke.Parent = mainFloatingBorder
    mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    mainStroke.Color = Color3.fromRGB(200, 200, 200)
    mainStroke.Thickness = 1
    mainStroke.Transparency = 0.8

    local borderCorner = Instance.new("UICorner")
    borderCorner.CornerRadius = Theme.Sizes.LargeRadius
    borderCorner.Parent = mainFloatingBorder

    local indicatorHeight = 50
    local collapsedWidth = 50
    local expandedWidth = 200
    local collapsedSize = UDim2.new(0, collapsedWidth, 0, indicatorHeight)
    local expandedSize = UDim2.new(0, expandedWidth, 0, indicatorHeight)
    local hiddenIndicator = Instance.new("TextButton")
    hiddenIndicator.AutoButtonColor = false
    hiddenIndicator.Name = "HiddenIndicator"
    hiddenIndicator.Parent = scrgui
    hiddenIndicator.AnchorPoint = Vector2.new(1, 0.5) 
    hiddenIndicator.Position = UDim2.new(1, expandedWidth, 0.5, 0)
    hiddenIndicator.Size = collapsedSize
    hiddenIndicator.BackgroundTransparency = 1
    hiddenIndicator.ZIndex = 8
    hiddenIndicator.Visible = false
    hiddenIndicator.Text = ""

    local hiBackground = Instance.new("Frame")
    hiBackground.Name = "BackgroundFrame"
    hiBackground.Parent = hiddenIndicator
    hiBackground.BackgroundTransparency = 1
    hiBackground.BorderSizePixel = 0
    hiBackground.Size = UDim2.new(1, 0, 1, 0)
    hiBackground.ZIndex = 1
    hiBackground.ClipsDescendants = true

    local hiLogo = Instance.new("ImageLabel", hiBackground)
    hiLogo.BackgroundTransparency = 1
    hiLogo.Size = UDim2.new(0, indicatorHeight, 0, indicatorHeight)
    hiLogo.Position = UDim2.new(0, indicatorHeight / 2, 0.5, 0)
    hiLogo.AnchorPoint = Vector2.new(0.5, 0.5)
    hiLogo.Image = "rbxassetid://101129417614969"
    hiLogo.ZIndex = 10 
    local hiLogoScale = Instance.new("UIScale", hiLogo)

    local hiText = Instance.new("TextLabel", hiBackground)
    hiText.BackgroundTransparency = 1
    hiText.Position = UDim2.new(0, indicatorHeight + 10, 0.5, 0)
    hiText.Size = UDim2.new(1, -(indicatorHeight + 20), 1, 0)
    hiText.AnchorPoint = Vector2.new(0, 0.5)
    hiText.Font = Theme.Fonts.Body
    hiText.TextColor3 = Theme.Colors.TextDark
    hiText.TextSize = 16
    hiText.ZIndex = 10
    hiText.Text = "Press " .. visiblekey.Name .. " to show" 
    hiText.TextXAlignment = Enum.TextXAlignment.Left
    hiText.TextYAlignment = Enum.TextYAlignment.Center 
    hiText.TextWrapped = true 
    hiText.Visible = false 
    
    hiddenIndicator.MouseEnter:Connect(function()
        if not visible then
            TweenService:Create(hiddenIndicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = expandedSize}):Play()
            hiText.Visible = true
        end
    end)

    hiddenIndicator.MouseLeave:Connect(function()
        if not visible then
            TweenService:Create(hiddenIndicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = collapsedSize}):Play()
            hiText.Visible = false
        end
    end)

    hiddenIndicator.MouseButton1Click:Connect(function()
        hiLogo.Rotation = 0
        hiLogoScale.Scale = 0.6
        TweenService:Create(hiLogo, TweenInfo.new(1.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Rotation = 360}):Play()
        TweenService:Create(hiLogoScale, TweenInfo.new(1.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Scale = 1}):Play()
        window:ToggleVisible()
    end)

    local mobileIndicator = Instance.new("TextButton")
    mobileIndicator.Name = "MobileIndicator"
    mobileIndicator.Parent = scrgui
    mobileIndicator.Size = UDim2.new(0, 45, 0, 45)
    mobileIndicator.Position = UDim2.new(0, 20, 0.5, 0)
    mobileIndicator.BackgroundColor3 = Theme.Colors.ContentBack
    mobileIndicator.BackgroundTransparency = 0
    mobileIndicator.ZIndex = 8
    mobileIndicator.Visible = false
    mobileIndicator.AutoButtonColor = false
    mobileIndicator.Text = ""
    mobileIndicator.Draggable = true
    mobileIndicator.Active = true

    local miCorner = Instance.new("UICorner", mobileIndicator)
    miCorner.CornerRadius = Theme.Sizes.SmallRadius

    local miStroke = Instance.new("UIStroke", mobileIndicator)
    miStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    miStroke.Color = Theme.Colors.Primary
    miStroke.Thickness = 1.5

    local miLogo = Instance.new("ImageLabel", mobileIndicator)
    miLogo.ZIndex = 9
    miLogo.BackgroundTransparency = 1
    miLogo.Size = UDim2.new(0, 45, 0, 45)
    miLogo.Position = UDim2.new(0.5, 0, 0.5, 0)
    miLogo.AnchorPoint = Vector2.new(0.5, 0.5)
    miLogo.Image = "rbxassetid://101129417614969"
    local miLogoScale = Instance.new("UIScale", miLogo)

    mobileIndicator.MouseButton1Click:Connect(function()
        if not visible then
            miLogo.Rotation = 0
            miLogoScale.Scale = 0.6
            TweenService:Create(miLogo, TweenInfo.new(1.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Rotation = 360}):Play()
            TweenService:Create(miLogoScale, TweenInfo.new(1.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Scale = 1}):Play()
            window:ToggleVisible()
        end
    end)

    updateLoadingProgress("Setting up components...", 0.5)
    task.wait(1)
    
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    local sidebarWidth = 200
    
    local workarea = Instance.new("Frame")
    workarea.Name = "workarea"
    workarea.Parent = main
    workarea.BackgroundColor3 = Theme.Colors.ContentBack

    workarea.Position = UDim2.new(0, sidebarWidth, 0, 30)
    workarea.Size = UDim2.new(1, -sidebarWidth, 1, -30) 
    workarea.Active = false

    workarea.ClipsDescendants = true 
    
    local uc_2 = Instance.new("UICorner")
    uc_2.CornerRadius = Theme.Sizes.LargeRadius
    uc_2.Parent = workarea

    local workareacornerhider = Instance.new("Frame")
    workareacornerhider.Name = "workareacornerhider"
    workareacornerhider.Parent = workarea
    workareacornerhider.BackgroundColor3 = Theme.Colors.ContentBack
    workareacornerhider.BorderSizePixel = 0
    workareacornerhider.Size = UDim2.new(0, 18, 1, 0)

    search = Instance.new("Frame")
    search.Name = "search"
    search.Parent = main
    search.BackgroundColor3 = Theme.Colors.LightGray
    search.BackgroundColor3 = Theme.Colors.ElementBack
    search.Position = UDim2.new(0, (sidebarWidth / 2), 0, 60)
    search.AnchorPoint = Vector2.new(0.5, 0)
    search.Size = UDim2.new(0, sidebarWidth - 30, 0, 34)

    local uc_8 = Instance.new("UICorner")
    uc_8.CornerRadius = Theme.Sizes.SmallRadius
    uc_8.Parent = search

    local searchicon = Instance.new("ImageButton")
    searchicon.Name = "searchicon"
    searchicon.Parent = search
    searchicon.BackgroundTransparency = 1
    searchicon.Position = UDim2.new(0, 10, 0.5, 0)
    searchicon.AnchorPoint = Vector2.new(0, 0.5)
    searchicon.Size = UDim2.new(0, 20, 0, 20)
    searchicon.Image = "rbxassetid://2804603863"
    searchicon.ImageColor3 = Theme.Colors.Text
    searchicon.ScaleType = Enum.ScaleType.Fit

    local searchtextbox = Instance.new("TextBox")
    searchtextbox.Name = "searchtextbox"
    searchtextbox.Parent = search
    searchtextbox.BackgroundTransparency = 1
    searchtextbox.ClipsDescendants = true
    searchtextbox.Position = UDim2.new(0, 38, 0.5, 0)
    searchtextbox.AnchorPoint = Vector2.new(0, 0.5)
    searchtextbox.Size = UDim2.new(1, -48, 1, 0)
    searchtextbox.Font = Theme.Fonts.Body
    searchtextbox.LineHeight = 0.870
    searchtextbox.PlaceholderText = "Search"
    searchtextbox.Text = ""
    searchtextbox.TextColor3 = Theme.Colors.Text
    searchtextbox.TextSize = 18
    searchtextbox.TextXAlignment = Enum.TextXAlignment.Left

    searchicon.MouseButton1Click:Connect(function()
        searchtextbox:CaptureFocus()
    end)

    main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = main.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if dragging then
                update(input)
            end
        end
    end)

    updateLoadingProgress("Configuring sidebar...", 0.75)
    task.wait(0.6)

    sidebar = Instance.new("ScrollingFrame")
    sidebar.Name = "sidebar"
    sidebar.Parent = main
    sidebar.Active = true
    sidebar.BackgroundTransparency = 0
    sidebar.BackgroundColor3 = Theme.Colors.MainBack
    sidebar.BorderSizePixel = 0
    sidebar.Position = UDim2.new(0, 10, 0, 104)

    sidebar.Size = UDim2.new(0, sidebarWidth - 15, 1, -119) 
    sidebar.AutomaticCanvasSize = "Y"
    sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
    sidebar.ScrollBarThickness = 2
    sidebar.ScrollBarImageTransparency = 0.5
    sidebar.ScrollBarImageColor3 = Theme.Colors.Text

    local ull_2 = Instance.new("UIListLayout")
    ull_2.Parent = sidebar
    ull_2.SortOrder = Enum.SortOrder.LayoutOrder
    ull_2.Padding = UDim.new(0, 5)

    searchtextbox:GetPropertyChangedSignal("Text"):Connect(function()
        local inputText = string.upper(searchtextbox.Text)
        
        for _, child in pairs(sidebar:GetChildren()) do
            if child.Name == "sidebar2" or child.Name == "sidebardivider" then
                local title = child:FindFirstChild("SectionTitle")
                local subtitle = child:FindFirstChild("SectionSubtitle")
                
                local found = false
                if title and string.find(string.upper(title.Text), inputText) then
                    found = true
                end
                if subtitle and string.find(string.upper(subtitle.Text), inputText) then
                    found = true
                end
                if inputText == "" then
                    found = true
                end

                if child.Name == "sidebardivider" then
                    if string.find(string.upper(child.Text), inputText) or inputText == "" then
                        found = true
                    end
                end

                child.Visible = found
            end
        end
    end)
    
    local buttons = Instance.new("Frame")
    buttons.Name = "buttons"
    buttons.Parent = main
    buttons.BackgroundTransparency = 1
    buttons.Size = UDim2.new(0, 80, 0, 30)
    buttons.Position = UDim2.new(0, 5, 0, 15)
    buttons.AnchorPoint = Vector2.new(0, 0.5)
    buttons.ZIndex = 20

    local ull_3 = Instance.new("UIListLayout")
    ull_3.Parent = buttons
    ull_3.FillDirection = Enum.FillDirection.Horizontal
    ull_3.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ull_3.SortOrder = Enum.SortOrder.LayoutOrder
    ull_3.VerticalAlignment = Enum.VerticalAlignment.Center
    ull_3.Padding = UDim.new(0, 10)

    local close = Instance.new("TextButton")
    close.Name = "close"
    close.Parent = buttons
    close.BackgroundColor3 = Theme.Colors.Close
    close.Size = UDim2.new(0, 16, 0, 16)
    close.AutoButtonColor = false
    close.ZIndex = 21
    close.Text = ""
    local closeIcon = Instance.new("ImageLabel", close)
    closeIcon.Name = "Icon"
    closeIcon.BackgroundTransparency = 1
    closeIcon.Size = UDim2.new(0, 10, 0, 10)
    closeIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
    closeIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    closeIcon.Image = Theme.Icons["x"]
    closeIcon.ImageTransparency = 1
    close.MouseButton1Click:Connect(function()
        window:Notify2(
            "CONFIRM CLOSE!",
            "Are you sure you want to destroy the UI?",
            "CLOSE",
            "CANCEL",
            "rbxassetid://12608260095",
            function() scrgui:Destroy() end,
            function() end,
            Theme.Colors.Close
        )
    end)

    local uc_18 = Instance.new("UICorner")
    uc_18.CornerRadius = Theme.Sizes.FullRadius
    uc_18.Parent = close

    local minimize = Instance.new("TextButton")
    minimize.Name = "minimize"
    minimize.Parent = buttons
    minimize.BackgroundColor3 = Theme.Colors.Minimize
    minimize.Size = UDim2.new(0, 16, 0, 16)
    minimize.AutoButtonColor = false
    minimize.ZIndex = 21
    minimize.Text = ""
    local minimizeIcon = Instance.new("ImageLabel", minimize)
    minimizeIcon.Name = "Icon"
    minimizeIcon.BackgroundTransparency = 1
    minimizeIcon.Size = UDim2.new(0, 10, 0, 10)
    minimizeIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
    minimizeIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    minimizeIcon.Image = Theme.Icons["minus"]
    minimizeIcon.ImageTransparency = 1

    minimize.MouseButton1Click:Connect(function()
        if UserInputService.TouchEnabled then
            window:ToggleVisible()
        end
    end)

    local uc_19 = Instance.new("UICorner")
    uc_19.CornerRadius = Theme.Sizes.FullRadius
    uc_19.Parent = minimize

    local resize = Instance.new("TextButton")
    resize.Name = "resize"
    resize.Parent = buttons
    resize.BackgroundColor3 = Theme.Colors.Resize
    resize.Size = UDim2.new(0, 16, 0, 16)
    resize.AutoButtonColor = false
    resize.ZIndex = 21
    resize.Text = ""
    local resizeIcon = Instance.new("ImageLabel", resize)
    resizeIcon.Name = "Icon"
    resizeIcon.BackgroundTransparency = 1
    resizeIcon.Size = UDim2.new(0, 10, 0, 10)
    resizeIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
    resizeIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    resizeIcon.Image = Theme.Icons["maximize-2"]
    resizeIcon.ImageTransparency = 1

    local function updateTrafficLights(hovering)
        local target = hovering and 0.5 or 1
        TweenService:Create(closeIcon, TweenInfo.new(0.2), {ImageTransparency = target}):Play()
        TweenService:Create(minimizeIcon, TweenInfo.new(0.2), {ImageTransparency = target}):Play()
        TweenService:Create(resizeIcon, TweenInfo.new(0.2), {ImageTransparency = target}):Play()
    end

    buttons.MouseEnter:Connect(function() updateTrafficLights(true) end)
    buttons.MouseLeave:Connect(function() updateTrafficLights(false) end)

    local uc_20 = Instance.new("UICorner")
    uc_20.CornerRadius = Theme.Sizes.FullRadius
    uc_20.Parent = resize
    
    local notif = Instance.new("CanvasGroup")
    notif.Name = "notif"
    notif.Parent = main
    notif.AnchorPoint = Vector2.new(0.5, 0.5)
    notif.BackgroundColor3 = Theme.Colors.ContentBack
    notif.Position = UDim2.new(0.5, 0, 0.5, 0)
    notif.Size = UDim2.new(0, 304, 0, 362)
    notif.Visible = false
    notif.ZIndex = 200

    local uc_11 = Instance.new("UICorner")
    uc_11.CornerRadius = Theme.Sizes.LargeRadius
    uc_11.Parent = notif

    local notificon = Instance.new("ImageLabel")
    notificon.Name = "notificon"
    notificon.Parent = notif
    notificon.BackgroundTransparency = 1
    notificon.Position = UDim2.new(0.335526317, 0, 0.0994475111, 0)
    notificon.Size = UDim2.new(0, 100, 0, 100)
    notificon.ZIndex = 201
    notificon.Image = "rbxassetid://4871684504"
    notificon.ImageColor3 = Theme.Colors.Text

    local notifbutton1 = Instance.new("TextButton")
    notifbutton1.Name = "notifbutton1"
    notifbutton1.Parent = notif
    notifbutton1.BackgroundColor3 = Theme.Colors.Primary
    notifbutton1.Position = UDim2.new(0.0559210554, 0, 0.817679524, 0)
    notifbutton1.Size = UDim2.new(0, 270, 0, 50)
    notifbutton1.ZIndex = 201
    notifbutton1.Font = Theme.Fonts.Body
    notifbutton1.Text = "OK"
    notifbutton1.TextColor3 = Theme.Colors.TextLight
    notifbutton1.TextSize = 21

    local uc_12 = Instance.new("UICorner")
    uc_12.CornerRadius = Theme.Sizes.SmallRadius
    uc_12.Parent = notifbutton1

    notifdarkness = Instance.new("CanvasGroup")
    notifdarkness.Name = "notifdarkness"
    notifdarkness.Parent = main 
    notifdarkness.AnchorPoint = Vector2.new(0.5, 0.5)
    notifdarkness.BackgroundColor3 = Theme.Colors.Shadow
    notifdarkness.BackgroundTransparency = 0.600
    notifdarkness.Position = UDim2.new(0.5, 0, 0.5, 0)
    notifdarkness.Size = UDim2.new(1, 0, 1, 0) 
    notifdarkness.ZIndex = 199
    notifdarkness.Visible = false 

    local uc_13 = Instance.new("UICorner")
    uc_13.CornerRadius = Theme.Sizes.LargeRadius
    uc_13.Parent = notifdarkness

    local notifshadow = Instance.new("ImageLabel")
    notifshadow.Name = "notifshadow"
    notifshadow.Parent = notifdarkness 
    notifshadow.AnchorPoint = Vector2.new(0.5, 0.5)
    notifshadow.BackgroundTransparency = 1
    notifshadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    notifshadow.Size = UDim2.new(1, 0, 1, 0) 
    notifshadow.ZIndex = notifdarkness.ZIndex - 1
    notifshadow.Image = "rbxassetid://313486536"
    notifshadow.ImageColor3 = Theme.Colors.Shadow
    notifshadow.ScaleType = Enum.ScaleType.Slice
    notifshadow.SliceCenter = Rect.new(100, 100, 100, 100)

    local notiftitle = Instance.new("TextLabel")
    notiftitle.Name = "notiftitle"
    notiftitle.Parent = notif
    notiftitle.BackgroundTransparency = 1
    notiftitle.Position = UDim2.new(0.167763159, 0, 0.375690609, 0)
    notiftitle.Size = UDim2.new(0, 200, 0, 50)
    notiftitle.ZIndex = 201
    notiftitle.Font = Theme.Fonts.Title
    notiftitle.Text = "Notice"
    notiftitle.TextColor3 = Theme.Colors.TextDark
    notiftitle.TextSize = 28

    local notiftext = Instance.new("TextLabel")
    notiftext.Name = "notiftext"
    notiftext.Parent = notif
    notiftext.BackgroundTransparency = 1
    notiftext.Position = UDim2.new(0.0822368413, 0, 0.513812184, 0)
    notiftext.Size = UDim2.new(0, 254, 0, 66)
    notiftext.ZIndex = 201
    notiftext.Font = Theme.Fonts.Body
    notiftext.Text = "We would like to contact you regarding your car's extended warranty."
    notiftext.TextColor3 = Theme.Colors.Text
    notiftext.TextSize = 16
    notiftext.TextWrapped = true

    local notif2 = Instance.new("CanvasGroup")
    notif2.Name = "notif2"
    notif2.Parent = main
    notif2.AnchorPoint = Vector2.new(0.5, 0.5)
    notif2.BackgroundColor3 = Theme.Colors.ContentBack
    notif2.Position = UDim2.new(0.5, 0, 0.5, 0)
    notif2.Size = UDim2.new(0, 304, 0, 362)
    notif2.Visible = false
    notif2.ZIndex = 200

    local uc_14 = Instance.new("UICorner")
    uc_14.CornerRadius = Theme.Sizes.LargeRadius
    uc_14.Parent = notif2

    local notif2icon = Instance.new("ImageLabel")
    notif2icon.Name = "notif2icon"
    notif2icon.Parent = notif2
    notif2icon.BackgroundTransparency = 1
    notif2icon.Position = UDim2.new(0.335526317, 0, 0.0994475111, 0)
    notif2icon.Size = UDim2.new(0, 100, 0, 100)
    notif2icon.ZIndex = 201
    notif2icon.Image = "rbxassetid://12608260095"
    notif2icon.ImageColor3 = Theme.Colors.Text

    local notif2title = Instance.new("TextLabel")
    notif2title.Name = "notif2title"
    notif2title.Parent = notif2
    notif2title.BackgroundTransparency = 1
    notif2title.Position = UDim2.new(0.167763159, 0, 0.375690609, 0)
    notif2title.Size = UDim2.new(0, 200, 0, 50)
    notif2title.ZIndex = 201
    notif2title.Font = Theme.Fonts.Title
    notif2title.Text = "Notice"
    notif2title.TextColor3 = Theme.Colors.TextDark
    notif2title.TextSize = 28

    local notif2text = Instance.new("TextLabel")
    notif2text.Name = "notif2text"
    notif2text.Parent = notif2
    notif2text.BackgroundTransparency = 1
    notif2text.Position = UDim2.new(0.0822368413, 0, 0.513812184, 0)
    notif2text.Size = UDim2.new(0, 254, 0, 66)
    notif2text.ZIndex = 201
    notif2text.Font = Theme.Fonts.Body
    notif2text.Text = "We would like to contact you regarding your car's extended warranty."
    notif2text.TextColor3 = Theme.Colors.Text
    notif2text.TextSize = 16
    notif2text.TextWrapped = true

    local notif2button1 = Instance.new("TextButton")
    notif2button1.Name = "notif2button1"
    notif2button1.Parent = notif2
    notif2button1.BackgroundColor3 = Theme.Colors.Primary
    notif2button1.Position = UDim2.new(0.0559210517, 0, 0.715469658, 0)
    notif2button1.Size = UDim2.new(0, 270, 0, 40)
    notif2button1.ZIndex = 201
    notif2button1.Font = Theme.Fonts.Body
    notif2button1.Text = "Sure!"
    notif2button1.TextColor3 = Theme.Colors.TextLight
    notif2button1.TextSize = 21

    local uc_15 = Instance.new("UICorner")
    uc_15.CornerRadius = Theme.Sizes.SmallRadius
    uc_15.Parent = notif2button1

    notif2darkness = Instance.new("CanvasGroup")
    notif2darkness.Name = "notif2darkness"
    notif2darkness.Parent = main 
    notif2darkness.AnchorPoint = Vector2.new(0.5, 0.5)
    notif2darkness.BackgroundColor3 = Theme.Colors.Shadow
    notif2darkness.BackgroundTransparency = 0.600
    notif2darkness.Position = UDim2.new(0.5, 0, 0.5, 0)
    notif2darkness.Size = UDim2.new(1, 0, 1, 0) 
    notif2darkness.ZIndex = 199
    notif2darkness.Visible = false 

    local uc_16 = Instance.new("UICorner")
    uc_16.CornerRadius = Theme.Sizes.LargeRadius
    uc_16.Parent = notif2darkness

    local notif2shadow = Instance.new("ImageLabel")
    notif2shadow.Name = "notif2shadow"
    notif2shadow.Parent = notif2darkness 
    notif2shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    notif2shadow.BackgroundTransparency = 1
    notif2shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    notif2shadow.Size = UDim2.new(1, 0, 1, 0) 
    notif2shadow.ZIndex = notif2darkness.ZIndex - 1
    notif2shadow.Image = "rbxassetid://313486536"
    notif2shadow.ImageColor3 = Theme.Colors.Shadow
    notif2shadow.ScaleType = Enum.ScaleType.Slice
    notif2shadow.SliceCenter = Rect.new(100, 100, 100, 100)

    local notif2button2 = Instance.new("TextButton")
    notif2button2.Name = "notif2button2"
    notif2button2.Parent = notif2
    notif2button2.BackgroundColor3 = Theme.Colors.Primary
    notif2button2.BackgroundTransparency = 1
    notif2button2.Position = UDim2.new(0.0526315793, 0, 0.842541456, 0)
    notif2button2.Size = UDim2.new(0, 270, 0, 40)
    notif2button2.ZIndex = 201
    notif2button2.Font = Theme.Fonts.Body
    notif2button2.Text = "Go away."
    notif2button2.TextColor3 = Theme.Colors.Text
    notif2button2.TextSize = 21

    local uc_17 = Instance.new("UICorner")
    uc_17.CornerRadius = Theme.Sizes.SmallRadius
    uc_17.Parent = notif2button2
    
    updateLoadingProgress("Finalizing...", 1.0)
    task.wait(0.8)
    
    if loadingScreen then
        tp(loadingScreen, UDim2.new(0.5, 0, -0.5, 0), 0.5)
        local blur = game:GetService("Lighting"):FindFirstChild("MacOsLibBlur")
        if blur then
            local tween = TweenService:Create(blur, TweenInfo.new(0.5), {Size = 0})
            tween.Completed:Connect(function()
                blur:Destroy()
            end)
            tween:Play()
        end
        Debris:AddItem(loadingScreen, 0.5)
    end

    -- Start with UI hidden and indicator shown
    if not UserInputService.TouchEnabled then
        hiddenIndicator.Size = collapsedSize
        hiddenIndicator.Visible = true
        tp(hiddenIndicator, UDim2.new(1, -10, 0.7, 0), 0.3) 
    else
        mobileIndicator.Visible = true
    end

    function window:ToggleVisible()
        if dbcooper then return end
        visible = not visible
        dbcooper = true
        if visible then
            hiddenIndicator.Size = collapsedSize
            if not UserInputService.TouchEnabled then
                hiddenIndicator.Visible = false
                tp(hiddenIndicator, UDim2.new(1, 190, 0.7, 0), 0.3)
            else 
                mobileIndicator.Visible = false
            end
            tp(main, UDim2.new(0.5, 0, 0.5, 0), 0.5)
            hiText.Visible = false
            task.wait(0.5)
            if not UserInputService.TouchEnabled then
                hiddenIndicator.Visible = false
            end
            dbcooper = false
        else
            tp(main, main.Position + UDim2.new(0, 0, 2, 0), 0.5)
            task.wait(0.5)
            if not UserInputService.TouchEnabled then
                hiddenIndicator.Size = collapsedSize
                hiddenIndicator.Visible = true
                tp(hiddenIndicator, UDim2.new(1, -10, 0.7, 0), 0.3) 
            else
                mobileIndicator.Visible = true
            end
            UserInputService.MouseIcon = ""
            dbcooper = false
        end
    end

    if visiblekey then
        minimize.MouseButton1Click:Connect(function()
            if not UserInputService.TouchEnabled then
                window:ToggleVisible()
            end
        end)
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if input.KeyCode == visiblekey then
                window:ToggleVisible()
            end
        end)
    end

    function window:GreenButton(callback)
        if window.greenButtonConnection then 
            window.greenButtonConnection:Disconnect() 
        end
        
        window.greenButtonConnection = resize.MouseButton1Click:Connect(function()
            isMaximized = not isMaximized
            local tweenTime = 0.3
            local tween
            
            if isMaximized then
                originalSize = main.AbsoluteSize
                originalPosition = main.Position
                
                local viewportSize = workspace.CurrentCamera.ViewportSize
                local newSize = viewportSize * 0.9
                local newPos = UDim2.new(0.5, 0, 0.5, 0)
                
                tween = TweenService:Create(main, TweenInfo.new(tweenTime), {Size = UDim2.new(0, newSize.X, 0, newSize.Y), Position = newPos})
                
            else
                if not originalSize then isMaximized = false; return end
                tween = TweenService:Create(main, TweenInfo.new(tweenTime), {Size = UDim2.new(0, originalSize.X, 0, originalSize.Y), Position = originalPosition})
            end
            
            tween:Play()
            tween.Completed:Wait()
            RunService.Heartbeat:Wait() -- Wait one frame for AbsoluteSize to propagate

            for i, section in ipairs(sections) do
                local workarea = workareas[i]
                if workarea and workarea.Visible then
                    local secAPI = sectionAPIs[i]
                    if secAPI and secAPI.Select then
                        secAPI:Select()
                    end
                end
            end

            if callback then
                task.spawn(callback, isMaximized)
            end
        end)
    end

    function window:TempNotify(text1, text2, icon)
        for b, v in next, scrgui:GetChildren() do
            if v.Name == "tempnotif" then
                v.Position += UDim2.new(0, 0, 0, 130)
            end
        end
        local tempnotif = Instance.new("Frame")
        tempnotif.Name = "tempnotif"
        tempnotif.Parent = scrgui
        tempnotif.AnchorPoint = Vector2.new(0.5, 0.5)
        tempnotif.BackgroundColor3 = Theme.Colors.MainBack
        tempnotif.BackgroundTransparency = 0.150
        tempnotif.Position = UDim2.new(1, -250, 0.0794737339, 0)
        tempnotif.Size = UDim2.new(0, 447, 0, 117)
        tempnotif.Visible = true
        tempnotif.ZIndex = 4

        local uc_21 = Instance.new("UICorner")
        uc_21.CornerRadius = Theme.Sizes.LargeRadius
        uc_21.Parent = tempnotif

        local t2 = Instance.new("TextLabel")
        t2.Name = "t2"
        t2.Parent = tempnotif
        t2.BackgroundTransparency = 1
        t2.Position = UDim2.new(0.236927822, 0, 0.470085472, 0)
        t2.Size = UDim2.new(0, 326, 0, 52)
        t2.ZIndex = 4
        t2.Font = Theme.Fonts.Body
        t2.Text = text2
        t2.TextColor3 = Theme.Colors.Text
        t2.TextSize = 16
        t2.TextWrapped = true
        t2.TextXAlignment = Enum.TextXAlignment.Left
        t2.TextYAlignment = Enum.TextYAlignment.Top

        local t1 = Instance.new("TextLabel")
        t1.Name = "t1"
        t1.Parent = tempnotif
        t1.BackgroundTransparency = 1
        t1.Position = UDim2.new(0.234690696, 0, 0.193464488, 0)
        t1.Size = UDim2.new(0, 327, 0, 25)
        t1.ZIndex = 4
        t1.Font = Theme.Fonts.Title
        t1.Text = text1
        t1.TextColor3 = Theme.Colors.TextDark
        t1.TextSize = 28
        t1.TextXAlignment = Enum.TextXAlignment.Left

        local ticon = Instance.new("ImageLabel")
        ticon.Name = "ticon"
        ticon.Parent = tempnotif
        ticon.BackgroundTransparency = 1
        ticon.Position = UDim2.new(0.0311112702, 0, 0.193464488, 0)
        ticon.Size = UDim2.new(0, 71, 0, 71)
        ticon.ZIndex = 4
        ticon.Image = Theme.Icons[icon] or icon
        ticon.ImageColor3 = Theme.Colors.Text
        ticon.ScaleType = Enum.ScaleType.Fit

    local tshadow = Instance.new("ImageLabel")
        tshadow.Name = "tshadow"
        tshadow.Parent = tempnotif
        tshadow.AnchorPoint = Vector2.new(0.5, 0.5)
        tshadow.BackgroundTransparency = 1
        tshadow.Position = UDim2.new(0.5, 0, 0.5, 0)
        tshadow.Size = UDim2.new(1.12, 0, 1.2, 0)
        tshadow.ZIndex = 3
        tshadow.Image = "rbxassetid://313486536"
        tshadow.ImageColor3 = Theme.Colors.Shadow
        tshadow.ImageTransparency = 0.400

        local tshadowCorner = Instance.new("UICorner")
        tshadowCorner.CornerRadius = Theme.Sizes.LargeRadius
        tshadowCorner.Parent = tshadow
        
        Debris:AddItem(tempnotif, 5)
    end

    function window:Notify(txt1, txt2, b1, icohn, callback)
        if notif.Visible == true or notif2.Visible == true then return "Already visible" end
        notiftitle.Text = txt1
        notiftext.Text = txt2
        notificon.Image = Theme.Icons[icohn] or icohn
        notif.Visible = true
        notifdarkness.Visible = true
        notifbutton1.Text = b1
        
        local con1
        con1 = notifbutton1.MouseButton1Click:Connect(function()
            if con1 then con1:Disconnect() end
            if callback then
                callback()
            end
            notif.Visible = false
            notifdarkness.Visible = false
        end)
    end


    function window:Notify2(txt1, txt2, b1, b2, icohn, callback, callback2, b1Color)
        if notif.Visible == true or notif2.Visible == true then return "Already visible" end
        notif2title.Text = txt1
        notif2text.Text = txt2
        notif2icon.Image = Theme.Icons[icohn] or icohn
        notif2.Visible = true
        notif2darkness.Visible = true
        notif2button1.Text = b1
        notif2button2.Text = b2
        

        notif2button1.BackgroundColor3 = b1Color or Theme.Colors.Primary
        
        if not b1Color then CollectionService:AddTag(notif2button1, "Theme_Primary_BackgroundColor3") end
        local con1, con2
        con1 = notif2button1.MouseButton1Click:Connect(function()
            con1:Disconnect()
            con2:Disconnect()
            if callback then callback() end
            notif2.Visible = false
            notif2darkness.Visible = false
        end)
        con2 = notif2button2.MouseButton1Click:Connect(function()
            con1:Disconnect()
            con2:Disconnect()
            if callback2 then callback2() end
            notif2.Visible = false
            notif2darkness.Visible = false
        end)
    end


    function window:Divider(name)
        local sidebardivider = Instance.new("TextLabel")
        sidebardivider.Name = "sidebardivider"
        sidebardivider.Parent = sidebar
        sidebardivider.BackgroundTransparency = 1
        sidebardivider.Size = UDim2.new(1, 0, 0, 26)
        sidebardivider.Font = Theme.Fonts.Body
        sidebardivider.Text = name
        sidebardivider.TextColor3 = Theme.Colors.Text
        sidebardivider.TextSize = 16
        sidebardivider.TextWrapped = true
        sidebardivider.TextXAlignment = Enum.TextXAlignment.Left
        sidebardivider.TextYAlignment = Enum.TextYAlignment.Bottom
        
        local pad = Instance.new("UIPadding", sidebardivider)
        pad.PaddingLeft = UDim.new(0, 10)
    end


    function window:Section(name, subtitle, icon)
        local sidebar2 = Instance.new("TextButton")
        sidebar2.Name = "sidebar2"
        sidebar2.Parent = sidebar
        sidebar2.BackgroundColor3 = Theme.Colors.Primary
        sidebar2.BackgroundTransparency = 1
        sidebar2.Size = UDim2.new(1, 0, 0, 50)
        sidebar2.ZIndex = 2
        sidebar2.AutoButtonColor = false
        sidebar2.Text = ""


        local selectionBar = Instance.new("Frame")
        selectionBar.Name = "SelectionBar"
        selectionBar.Parent = sidebar2 
        selectionBar.BackgroundColor3 = Theme.Colors.ElementBack
        selectionBar.BackgroundTransparency = 1
        selectionBar.BorderSizePixel = 0
        selectionBar.Size = UDim2.new(1, -10, 1, -8)
        selectionBar.Position = UDim2.new(0, 5, 0, 4)
        selectionBar.ZIndex = 2
        local sbCorner = Instance.new("UICorner", selectionBar)
        sbCorner.CornerRadius = Theme.Sizes.SmallRadius


        local sectionIcon = Instance.new("ImageLabel")
        sectionIcon.Name = "SectionIcon"
        sectionIcon.Parent = sidebar2
        sectionIcon.BackgroundTransparency = 1
        sectionIcon.Position = UDim2.new(0, 26, 0.5, 0)
        sectionIcon.AnchorPoint = Vector2.new(0.5, 0.5)
        sectionIcon.Size = UDim2.new(0, 22, 0, 22)
        sectionIcon.ZIndex = 3
        sectionIcon.Image = Theme.Icons[icon] or icon
        sectionIcon.ImageColor3 = Theme.Colors.Primary
        sectionIcon.ScaleType = Enum.ScaleType.Fit
        local sectionIconScale = Instance.new("UIScale", sectionIcon)
        

        local sectionTitle = Instance.new("TextLabel")
        sectionTitle.Name = "SectionTitle"
        sectionTitle.Parent = sidebar2
        sectionTitle.BackgroundTransparency = 1
        sectionTitle.Font = Theme.Fonts.Title
        sectionTitle.Text = name
        sectionTitle.TextColor3 = Theme.Colors.Primary
        sectionTitle.TextSize = 18
        sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
        sectionTitle.ZIndex = 3
        sectionTitle.Position = UDim2.new(0, 48, 0.5, -9)
        sectionTitle.AnchorPoint = Vector2.new(0, 0.5)
        sectionTitle.Size = UDim2.new(1, -75, 0, 20)
        

        local sectionSubtitle = Instance.new("TextLabel")
        sectionSubtitle.Name = "SectionSubtitle"
        sectionSubtitle.Parent = sidebar2
        sectionSubtitle.BackgroundTransparency = 1
        sectionSubtitle.Font = Theme.Fonts.Body
        sectionSubtitle.Text = subtitle
        sectionSubtitle.TextColor3 = Theme.Colors.Gray
        sectionSubtitle.TextSize = 14
        sectionSubtitle.TextXAlignment = Enum.TextXAlignment.Left
        sectionSubtitle.ZIndex = 3
        sectionSubtitle.Position = UDim2.new(0, 48, 0.5, 9)
        sectionSubtitle.AnchorPoint = Vector2.new(0, 0.5)
        sectionSubtitle.Size = UDim2.new(1, -75, 0, 16)
        
        table.insert(sections, sidebar2)

        local workareamain = Instance.new("ScrollingFrame")
        workareamain.Name = "workareamain"
        workareamain.Parent = workarea
        workareamain.Active = true
        workareamain.BackgroundTransparency = 1
        workareamain.BorderSizePixel = 0 
        workareamain.Position = UDim2.new(0, 20, 0, 85)
        workareamain.Size = UDim2.new(1, -40, 1, -100)
        workareamain.Position = UDim2.new(0, 20, 0, 20)
        workareamain.Size = UDim2.new(1, -40, 1, -40)
        workareamain.ZIndex = 3
        workareamain.AutomaticCanvasSize = "Y"
        workareamain.CanvasSize = UDim2.new(0, 0, 0, 0)
        workareamain.ScrollBarThickness = 2
        workareamain.ScrollBarImageTransparency = 0.5
        workareamain.ScrollBarImageColor3 = Theme.Colors.Text
        workareamain.Visible = false
        
        local pad = Instance.new("UIPadding", workareamain)
        pad.Name = "pad"
        pad.PaddingTop = UDim.new(0, 10)
        pad.PaddingRight = UDim.new(0, 10)

        local ull = Instance.new("UIListLayout")
        ull.Parent = workareamain
        ull.HorizontalAlignment = Enum.HorizontalAlignment.Center
        ull.SortOrder = Enum.SortOrder.LayoutOrder
        ull.Padding = UDim.new(0, 8)

        table.insert(workareas, workareamain)

        local sec = {}
        local layoutOrderCounter = 0
        

        function sec:Select()
            for b, v in next, sections do

                TweenService:Create(v:FindFirstChild("SelectionBar"), TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
                local title = v:FindFirstChild("SectionTitle")
                local subtitle = v:FindFirstChild("SectionSubtitle")
                local iconInstance = v:FindFirstChild("SectionIcon")

                if title then title.TextColor3 = Theme.Colors.Primary end
                if subtitle then subtitle.TextColor3 = Theme.Colors.Gray end
                if iconInstance then iconInstance.ImageColor3 = Theme.Colors.Primary end
            end
            

            TweenService:Create(selectionBar, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
            local currentTitle = sidebar2:FindFirstChild("SectionTitle")
            local currentSubtitle = sidebar2:FindFirstChild("SectionSubtitle")
            local selectedIcon = sidebar2:FindFirstChild("SectionIcon")

            if currentTitle then currentTitle.TextColor3 = Theme.Colors.Primary end
            if currentSubtitle then currentSubtitle.TextColor3 = Theme.Colors.Text end
            if selectedIcon then selectedIcon.ImageColor3 = Theme.Colors.Primary end
            CollectionService:AddTag(selectedIcon, "Theme_Primary_ImageColor3")


            if activeWorkarea ~= workareamain then
                local oldWorkarea = activeWorkarea
                activeWorkarea = workareamain

                local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                local targetInPosition = UDim2.new(0, 20, 0, 85)
                local targetInPosition = UDim2.new(0, 20, 0, 20)

                workareamain.ZIndex = 4
                workareamain.Position = UDim2.new(1, 20, 0, 85)
                workareamain.Position = UDim2.new(1, 20, 0, 20)
                workareamain.Visible = true
                TweenService:Create(workareamain, tweenInfo, {Position = targetInPosition}):Play()


                if oldWorkarea then
                    local targetOutPosition = UDim2.new(-1, 20, 0, 85)
                    local targetOutPosition = UDim2.new(-1, 20, 0, 20)
                    TweenService:Create(oldWorkarea, tweenInfo, {Position = targetOutPosition}):Play()
                    task.delay(tweenInfo.Time, function()
                        if oldWorkarea and oldWorkarea.Parent and activeWorkarea ~= oldWorkarea then
                            oldWorkarea.Visible = false
                            oldWorkarea.ZIndex = 3
                        end
                    end)
                end
            end
            
            -- 1. Collect all existing items into a flat list
            local allItems = {}
            local oldContainer = workareamain:FindFirstChild("LayoutColumn_Container")
            if oldContainer then
                -- Collect from existing columns
                for _, column in ipairs(oldContainer:GetChildren()) do
                    if column.Name:find("LayoutColumn_") then
                        for _, item in ipairs(column:GetChildren()) do
                            if item:IsA("GuiObject") then table.insert(allItems, item) end
                        end
                    end
                end
            else
                -- Collect from single-column view
                for _, child in ipairs(workareamain:GetChildren()) do
                    -- Collect any GUI object that isn't a layout helper
                    if child:IsA("GuiObject") and not child:IsA("UILayout") and child.Name ~= "pad" then
                        table.insert(allItems, child)
                    end
                end
            end

            -- 2. Determine layout parameters
            local splitThreshold = 1 -- How many items are needed to justify splitting
            local itemCount = #allItems
            local workareaWidth = workareamain.AbsoluteSize.X
            local minColumnWidth = 300
            local numColumns
            
            if isMaximized then
                numColumns = math.max(1, math.floor(workareaWidth / minColumnWidth))
                pad.PaddingTop = UDim.new(0, 25)
            else
                numColumns = 1
                pad.PaddingTop = UDim.new(0, 10)
            end

            -- 3. Detach all items and current layouts
            for _, item in ipairs(allItems) do item.Parent = nil end
            if oldContainer then oldContainer:Destroy() end
            if ull then ull.Parent = nil end -- ull is the single-column layout

            -- 4. Sort items by their original layout order
            table.sort(allItems, function(a, b) return a.LayoutOrder < b.LayoutOrder end)

            -- 5. Apply the new layout
            if numColumns > 1 and itemCount > splitThreshold then
                -- APPLY MULTI-COLUMN LAYOUT
                local columnsContainer = Instance.new("Frame", workareamain)
                columnsContainer.Name = "LayoutColumn_Container"
                columnsContainer.BackgroundTransparency = 1
                columnsContainer.Size = UDim2.new(1, 0, 0, 0)
                columnsContainer.AutomaticSize = Enum.AutomaticSize.Y
                
                local columnsLayout = Instance.new("UIListLayout", columnsContainer)
                columnsLayout.FillDirection = Enum.FillDirection.Horizontal
                columnsLayout.VerticalAlignment = Enum.VerticalAlignment.Top
                columnsLayout.Padding = UDim.new(0, 20)
                
                local columns = {}
                local columnPadding = columnsLayout.Padding.Offset * (numColumns - 1)
                local columnWidth = UDim2.new(1 / numColumns, -columnPadding / numColumns, 0, 0)
                
                for i = 1, numColumns do
                    local column = Instance.new("Frame", columnsContainer)
                    column.Name = "LayoutColumn_" .. i
                    column.BackgroundTransparency = 1
                    column.Size = columnWidth
                    column.AutomaticSize = Enum.AutomaticSize.Y
                    
                    local columnListLayout = Instance.new("UIListLayout", column)
                    columnListLayout.Padding = UDim.new(0, 8)
                    columnListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    table.insert(columns, column)
                end
                
                -- Distribute items into columns (vertical fill)
                local itemsPerColumn = math.ceil(#allItems / numColumns)
                for i, item in ipairs(allItems) do
                    local columnIndex = math.floor((i - 1) / itemsPerColumn) + 1
                    columnIndex = math.min(columnIndex, numColumns)
                    item.Parent = columns[columnIndex]
                end
            else
                -- APPLY SINGLE-COLUMN LAYOUT
                for _, item in ipairs(allItems) do item.Parent = workareamain end
                if ull then ull.Parent = workareamain end
            end

            -- 6. Reset scroll position
            RunService.Heartbeat:Wait()
            workareamain.CanvasSize = UDim2.new()
            workareamain.CanvasPosition = Vector2.new(0,0)
        end
        
        table.insert(sectionAPIs, sec)

        function sec:Section(sectionName, startClosed)
            layoutOrderCounter = layoutOrderCounter + 1
            local sectionLayoutOrderCounter = 0
            local section = {}
            local collapsed = startClosed or false

            local SectionContainer = Instance.new("Frame")
            SectionContainer.Name = sectionName .. "_Section"
            SectionContainer.Parent = workareamain
            SectionContainer.BackgroundColor3 = Theme.Colors.SectionBack
            SectionContainer.Size = UDim2.new(1, 0, 0, 0)
            SectionContainer.AutomaticSize = Enum.AutomaticSize.Y
            SectionContainer.LayoutOrder = layoutOrderCounter
            SectionContainer.ClipsDescendants = false
            local sc_uc = Instance.new("UICorner", SectionContainer)
            sc_uc.CornerRadius = Theme.Sizes.SmallRadius

            local SectionLayout = Instance.new("UIListLayout")
            SectionLayout.Parent = SectionContainer
            SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionLayout.Padding = UDim.new(0, 0)

           -- Header Button (Click to toggle)
            local SectionHeader = Instance.new("TextButton")
            SectionHeader.Name = "Header"
            SectionHeader.Parent = SectionContainer
            SectionHeader.BackgroundColor3 = Theme.Colors.SectionBack
            SectionHeader.BackgroundTransparency = 0  -- CHANGED: Make background visible
            SectionHeader.Size = UDim2.new(1, 0, 0, 40)  -- CHANGED: Increased from 35 to 40
            SectionHeader.AutoButtonColor = false
            SectionHeader.Font = Theme.Fonts.Title
            SectionHeader.Text = "  " .. sectionName
            SectionHeader.TextColor3 = Theme.Colors.Text
            SectionHeader.TextSize = 14  -- CHANGED: Increased from 13 to 14
            SectionHeader.TextXAlignment = Enum.TextXAlignment.Left
            SectionHeader.ClipsDescendants = false  -- ADDED: Don't clip content
            local sh_uc = Instance.new("UICorner", SectionHeader)
            sh_uc.CornerRadius = Theme.Sizes.SmallRadius

            local ArrowIcon = Instance.new("ImageLabel")
            ArrowIcon.Name = "Arrow"
            ArrowIcon.Parent = SectionHeader
            ArrowIcon.AnchorPoint = Vector2.new(1, 0.5)
            ArrowIcon.BackgroundTransparency = 1
            ArrowIcon.Position = UDim2.new(1, -10, 0.5, 0)
            ArrowIcon.Size = UDim2.new(0, 16, 0, 16)
            ArrowIcon.Image = "rbxassetid://6031090990" -- Down arrow asset
            ArrowIcon.ImageColor3 = Theme.Colors.Text
            ArrowIcon.Rotation = collapsed and -90 or 0 -- 0 is expanded, -90 is collapsed

            -- Content Holder
            local SectionContent = Instance.new("Frame")
            SectionContent.Name = "Content"
            SectionContent.Parent = SectionContainer
            SectionContent.BackgroundColor3 = Theme.Colors.SectionBack
            SectionContent.BackgroundTransparency = 1
            SectionContent.Size = UDim2.new(1, 0, 0, 0)
            SectionContent.AutomaticSize = Enum.AutomaticSize.Y
            SectionContent.ClipsDescendants = true
            SectionContent.Visible = not collapsed -- start based on collapsed state

            local SectionContentLayout = Instance.new("UIListLayout")
            SectionContentLayout.Parent = SectionContent
            SectionContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionContentLayout.Padding = UDim.new(0, 8)

            local SectionContentPadding = Instance.new("UIPadding")
            SectionContentPadding.Parent = SectionContent
            SectionContentPadding.PaddingTop = UDim.new(0, 5)
            SectionContentPadding.PaddingBottom = UDim.new(0, 10)
            SectionContentPadding.PaddingLeft = UDim.new(0, 10)
            SectionContentPadding.PaddingRight = UDim.new(0, 10)

            -- Toggle Logic
            local tweening = false
            SectionHeader.MouseButton1Click:Connect(function()
                if tweening then return end
                tweening = true

                collapsed = not collapsed
                local targetRotation = collapsed and -90 or 0
                local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

                TweenService:Create(ArrowIcon, tweenInfo, {Rotation = targetRotation}):Play()

                if collapsed then
                    -- COLLAPSING
                    local currentHeight = SectionContent.AbsoluteSize.Y
                    SectionContent.AutomaticSize = Enum.AutomaticSize.None
                    SectionContent.Size = UDim2.new(1, 0, 0, currentHeight)

                    local tween = TweenService:Create(SectionContent, tweenInfo, {Size = UDim2.new(1, 0, 0, 0)})
                    tween.Completed:Connect(function()
                        SectionContent.Visible = false
                        SectionContent.AutomaticSize = Enum.AutomaticSize.Y -- Reset for next expansion
                        tweening = false
                    end)
                    tween:Play()
                else
                    -- EXPANDING
                    -- To prevent flicker, we calculate the target height using an off-screen clone
                    local clone = SectionContent:Clone()
                    clone.Parent = scrgui
                    clone.Position = UDim2.new(5, 0, 5, 0) -- Position it way off-screen
                    clone.AutomaticSize = Enum.AutomaticSize.Y
                    clone.Visible = true
                    
                    RunService.Heartbeat:Wait() -- Let the clone calculate its size
                    
                    local targetHeight = clone.AbsoluteSize.Y
                    clone:Destroy()

                    -- Now, animate the actual SectionContent frame, which is starting at size 0
                    SectionContent.Visible = true
                    SectionContent.AutomaticSize = Enum.AutomaticSize.None
                    SectionContent.Size = UDim2.new(1, 0, 0, 0)

                    local tween = TweenService:Create(SectionContent, tweenInfo, {Size = UDim2.new(1, 0, 0, targetHeight)})
                    tween.Completed:Connect(function()
                        SectionContent.AutomaticSize = Enum.AutomaticSize.Y -- Let it manage its own size again
                        tweening = false
                    end)
                    tween:Play()
                end
            end)

            function section:Button(text, callback)
                sectionLayoutOrderCounter = sectionLayoutOrderCounter + 1
                local button = Instance.new("TextButton")
                button.Name = "button"
                button.Parent = SectionContent
                button.BackgroundColor3 = Theme.Colors.ElementBack
                button.Size = UDim2.new(1, 0, 0, 32)
                button.ZIndex = 2
                button.Font = Theme.Fonts.Body
                button.Text = text or "Button"
                button.TextColor3 = Theme.Colors.Text
                button.TextSize = 14
                button.AutoButtonColor = false
                button.LayoutOrder = sectionLayoutOrderCounter

                local uc_3 = Instance.new("UICorner")
                uc_3.CornerRadius = Theme.Sizes.SmallRadius
                uc_3.Parent = button

                local btnScale = Instance.new("UIScale", button)
                
                button.MouseButton1Down:Connect(function()
                    TweenService:Create(btnScale, TweenInfo.new(0.1), {Scale = 0.96}):Play()
                end)
                button.MouseButton1Up:Connect(function()
                    TweenService:Create(btnScale, TweenInfo.new(0.1), {Scale = 1}):Play()
                end)

                button.MouseEnter:Connect(function()
                    TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = Theme.Colors.Hover}):Play()
                end)

                button.MouseLeave:Connect(function()
                    TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = Theme.Colors.ElementBack}):Play()
                    TweenService:Create(btnScale, TweenInfo.new(0.1), {Scale = 1}):Play()
                end)

                if callback then
                    button.MouseButton1Click:Connect(function()
                        TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Colors.Primary}):Play()
                        task.wait(0.1)
                        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Colors.ElementBack}):Play()
                        task.spawn(callback)
                    end)
                end
            end

            function section:Label(name)
                sectionLayoutOrderCounter = sectionLayoutOrderCounter + 1
                local label = Instance.new("TextLabel")
                label.Name = "label"
                label.Parent = SectionContent
                label.BackgroundTransparency = 1
                label.Size = UDim2.new(1, 0, 0, 37)
                label.Font = Theme.Fonts.Body
                label.TextColor3 = Theme.Colors.Text
                label.TextSize = 14
                label.TextWrapped = true
                label.Text = name
                label.LayoutOrder = sectionLayoutOrderCounter
                label.TextXAlignment = Enum.TextXAlignment.Left
            end

            function section:Switch(text, default, callback)
                sectionLayoutOrderCounter = sectionLayoutOrderCounter + 1
                local toggled = default or false
                
                local ToggleFrame = Instance.new("TextButton")
                ToggleFrame.Name = "toggleswitch"
                ToggleFrame.Parent = SectionContent
                ToggleFrame.BackgroundColor3 = Theme.Colors.ElementBack
                ToggleFrame.Size = UDim2.new(1, 0, 0, 32)
                ToggleFrame.AutoButtonColor = false
                ToggleFrame.Text = ""
                ToggleFrame.LayoutOrder = sectionLayoutOrderCounter
                local corner = Instance.new("UICorner", ToggleFrame)
                corner.CornerRadius = Theme.Sizes.SmallRadius

                local ToggleLabel = Instance.new("TextLabel")
                ToggleLabel.Parent = ToggleFrame
                ToggleLabel.BackgroundTransparency = 1
                ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
                ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
                ToggleLabel.Font = Theme.Fonts.Body
                ToggleLabel.Text = text or "Switch"
                ToggleLabel.TextColor3 = Theme.Colors.Text
                ToggleLabel.TextSize = 14
                ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left

                local ToggleIndicator = Instance.new("Frame")
                ToggleIndicator.Parent = ToggleFrame
                ToggleIndicator.AnchorPoint = Vector2.new(1, 0.5)
                ToggleIndicator.BackgroundColor3 = toggled and Theme.Colors.Primary or Theme.Colors.ContentBack
                ToggleIndicator.Position = UDim2.new(1, -10, 0.5, 0)
                CollectionService:AddTag(ToggleIndicator, "Theme_Primary_BackgroundColor3_Switch")
                ToggleIndicator.Size = UDim2.new(0, 36, 0, 18)
                local indCorner = Instance.new("UICorner", ToggleIndicator)
                indCorner.CornerRadius = UDim.new(1,0)
                local indStroke = Instance.new("UIStroke", ToggleIndicator)
                indStroke.Color = Theme.Colors.Border
                indStroke.Thickness = 1
                indStroke.Parent = ToggleIndicator

                local ToggleCircle = Instance.new("Frame")
                ToggleCircle.Parent = ToggleIndicator
                ToggleCircle.BackgroundColor3 = Theme.Colors.Text
                ToggleCircle.Size = UDim2.new(0, 14, 0, 14)
                local circScale = Instance.new("UIScale", ToggleCircle)

                local circCorner = Instance.new("UICorner", ToggleCircle)
                circCorner.CornerRadius = UDim.new(1,0)

                local offPos = UDim2.new(0, 2, 0, 2)
                local onPos = UDim2.new(0, 20, 0, 2)
                ToggleCircle.Position = toggled and onPos or offPos

                local function handleToggle()
                    toggled = not toggled
                    local targetColor = toggled and Theme.Colors.Primary or Theme.Colors.ContentBack
                    local targetPos = toggled and onPos or offPos

                    local mainTweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
                    local scaleTweenInfo = TweenInfo.new(mainTweenInfo.Time / 2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)

                    TweenService:Create(ToggleIndicator, mainTweenInfo, {BackgroundColor3 = targetColor}):Play()
                    TweenService:Create(ToggleCircle, mainTweenInfo, {Position = targetPos}):Play()

                    local scaleTween1 = TweenService:Create(circScale, scaleTweenInfo, {Scale = 1.2})
                    scaleTween1.Completed:Connect(function()
                        TweenService:Create(circScale, scaleTweenInfo, {Scale = 1}):Play()
                    end)
                    scaleTween1:Play()
                    if callback then
                        task.spawn(callback, toggled)
                    end
                end

                ToggleFrame.MouseButton1Click:Connect(handleToggle)
                ToggleFrame.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.Touch then
                        handleToggle()
                    end
                end)
            end

            function section:TextField(text, placeholder, callback)
                sectionLayoutOrderCounter = sectionLayoutOrderCounter + 1
                
                local textfield = Instance.new("TextLabel")
                textfield.Name = "textfield"
                textfield.Parent = SectionContent
                textfield.BackgroundTransparency = 1
                textfield.Size = UDim2.new(1, 0, 0, 37)
                textfield.Font = Theme.Fonts.Body
                textfield.Text = text
                textfield.TextColor3 = Theme.Colors.Text
                textfield.TextSize = 14
                textfield.TextWrapped = true
                textfield.TextXAlignment = Enum.TextXAlignment.Left
                textfield.LayoutOrder = sectionLayoutOrderCounter
                
                local Frame_2 = Instance.new("Frame")
                Frame_2.Parent = textfield
                Frame_2.BackgroundColor3 = Theme.Colors.ElementBack
                Frame_2.Position = UDim2.new(0.5, 0, 0.5, 0)
                Frame_2.AnchorPoint = Vector2.new(0, 0.5)
                Frame_2.Size = UDim2.new(0.5, 0, 1, -6)

                local uc_6 = Instance.new("UICorner")
                uc_6.CornerRadius = Theme.Sizes.SmallRadius
                uc_6.Parent = Frame_2

                local TextBox = Instance.new("TextBox")
                TextBox.Parent = Frame_2
                TextBox.BackgroundTransparency = 1
                TextBox.BorderSizePixel = 0
                TextBox.ClipsDescendants = true
                TextBox.Position = UDim2.new(0, 10, 0, 0)
                TextBox.Size = UDim2.new(1, -20, 1, 0)
                TextBox.ClearTextOnFocus = false
                TextBox.Font = Theme.Fonts.Body
                TextBox.PlaceholderColor3 = Theme.Colors.TextDark
                TextBox.PlaceholderText = placeholder or "Type here..."
                TextBox.Text = ""
                TextBox.TextColor3 = Theme.Colors.Text
                TextBox.TextSize = 14
                TextBox.TextXAlignment = Enum.TextXAlignment.Left

                if callback then
                    TextBox.FocusLost:Connect(function(enterPressed)
                        if enterPressed then
                            callback(TextBox.Text)
                        end
                    end)
                end
            end

            function section:Slider(text, min, max, default, callback)
                sectionLayoutOrderCounter = sectionLayoutOrderCounter + 1
                
                local sliderContainer = Instance.new("TextLabel")
                sliderContainer.Name = "slider"
                sliderContainer.Parent = SectionContent
                sliderContainer.BackgroundTransparency = 1
                sliderContainer.Size = UDim2.new(1, 0, 0, 50)
                sliderContainer.Font = Theme.Fonts.Body
                sliderContainer.Text = text or "Slider"
                sliderContainer.TextColor3 = Theme.Colors.Text
                sliderContainer.TextSize = 14
                sliderContainer.TextWrapped = true
                sliderContainer.TextXAlignment = Enum.TextXAlignment.Left
                sliderContainer.LayoutOrder = sectionLayoutOrderCounter
    
                local valueLabel = Instance.new("TextLabel")
                valueLabel.Name = "ValueLabel"
                valueLabel.Parent = sliderContainer
                valueLabel.BackgroundTransparency = 1
                valueLabel.Font = Theme.Fonts.Body
                valueLabel.TextColor3 = Theme.Colors.Text
                valueLabel.TextSize = 14
                valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    
                valueLabel.Position = UDim2.new(0.5, 0, 0, 0)
                valueLabel.AnchorPoint = Vector2.new(0, 0)
                valueLabel.Size = UDim2.new(0.5, 0, 0, 20)
    
                local track = Instance.new("Frame")
                track.Name = "Track"
                track.Parent = sliderContainer
                track.BackgroundColor3 = Theme.Colors.ElementBack
    
                track.Position = UDim2.new(0.5, 0, 0.6, 0)
                track.AnchorPoint = Vector2.new(0, 0)
                track.Size = UDim2.new(0.5, 0, 0, 6)
                local trackCorner = Instance.new("UICorner", track)
                trackCorner.CornerRadius = Theme.Sizes.FullRadius
    
                local fill = Instance.new("Frame")
                fill.Name = "Fill"
                fill.Parent = track
                fill.BackgroundColor3 = Theme.Colors.Primary
                fill.Size = UDim2.new(0, 0, 1, 0)
                local fillCorner = Instance.new("UICorner", fill)
                fillCorner.CornerRadius = Theme.Sizes.FullRadius
                
                createGradient(fill, Theme.Colors.Primary, Theme.Colors.PrimaryLight)
    
                local thumb = Instance.new("TextButton")
                thumb.Name = "Thumb"
                thumb.Parent = track
                thumb.BackgroundColor3 = Theme.Colors.TextLight
                thumb.Size = UDim2.new(0, 16, 0, 16)
                thumb.AnchorPoint = Vector2.new(0.5, 0.5)
                thumb.Position = UDim2.new(0, 0, 0.5, 0)
                thumb.ZIndex = 3
                thumb.Text = ""
                local thumbCorner = Instance.new("UICorner", thumb)
                thumbCorner.CornerRadius = Theme.Sizes.FullRadius
                local thumbStroke = Instance.new("UIStroke", thumb)
                thumbStroke.Color = Theme.Colors.Gray
                thumbStroke.Thickness = 1
    
                local currentValue = default or (min or 0)
    
                local function updateSlider(value, runCallback)
                    local v_min = min or 0
                    local v_max = max or 100
                    currentValue = math.clamp(value, v_min, v_max)
                    local percentage = (currentValue - v_min) / (v_max - v_min)
                    
                    valueLabel.Text = tostring(math.floor(currentValue * 100) / 100) 
                    
                    local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    TweenService:Create(fill, tweenInfo, {Size = UDim2.new(percentage, 0, 1, 0)}):Play()
                    TweenService:Create(thumb, tweenInfo, {Position = UDim2.new(percentage, 0, 0.5, 0)}):Play()
    
                    if runCallback and callback then
                        task.spawn(callback, currentValue)
                    end
                end
    
                thumb.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        local moveConn, releaseConn
                        moveConn = UserInputService.InputChanged:Connect(function(moveInput)
                            local v_min = min or 0
                            local v_max = max or 100
                            local percentage = (moveInput.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
                            local newValue = v_min + (v_max - v_min) * math.clamp(percentage, 0, 1)
                            updateSlider(newValue, true)
                        end)
                        releaseConn = UserInputService.InputEnded:Connect(function()
                            moveConn:Disconnect()
                            releaseConn:Disconnect()
                        end)
                    end
                end)
    
                updateSlider(currentValue, false)
            end

            function section:Dropdown(name, list, multi, p4, p5)
                local defaultValue, callback
                if type(p4) == 'function' and p5 == nil then
                    defaultValue = nil
                    callback = p4
                else
                    defaultValue = p4
                    callback = p5
                end

                sectionLayoutOrderCounter = sectionLayoutOrderCounter + 1
                local dropdown = Instance.new("TextLabel")
                dropdown.Name = "dropdown"
                dropdown.Parent = SectionContent
                dropdown.BackgroundTransparency = 1
                dropdown.Size = UDim2.new(1, 0, 0, 37)
                dropdown.Font = Theme.Fonts.Body
                dropdown.Text = name
                dropdown.TextColor3 = Theme.Colors.Text
                dropdown.TextSize = 14
                dropdown.TextXAlignment = Enum.TextXAlignment.Left
                dropdown.LayoutOrder = sectionLayoutOrderCounter
    
                local selectedItems = {}
                local isMultiSelect = multi or false
    
                local dropdownButton = Instance.new("TextButton")
                dropdownButton.Name = "DropdownButton"
                dropdownButton.Parent = dropdown
                dropdownButton.BackgroundColor3 = Theme.Colors.ElementBack
                dropdownButton.Position = UDim2.new(0.5, 0, 0.5, 0)
                dropdownButton.AnchorPoint = Vector2.new(0, 0.5)
                dropdownButton.Size = UDim2.new(0.5, 0, 1, -6)
                dropdownButton.Font = Theme.Fonts.Body
                dropdownButton.Text = (isMultiSelect and "Select") or (defaultValue or list[1] or "Select")

                -- Initialize selectedItems from defaultValue for multi-select
                if isMultiSelect and defaultValue and type(defaultValue) == "table" then
                    for _, item in ipairs(defaultValue) do
                        selectedItems[item] = true
                    end
                    if #defaultValue > 0 then
                        dropdownButton.Text = table.concat(defaultValue, ", ")
                    end
                end

                dropdownButton.TextColor3 = Theme.Colors.Text
                dropdownButton.TextSize = 14
                dropdownButton.ZIndex = 8
                dropdownButton.TextXAlignment = Enum.TextXAlignment.Left
                dropdownButton.TextTruncate = Enum.TextTruncate.AtEnd
    
                local textPadding = Instance.new("UIPadding", dropdownButton)
                textPadding.PaddingLeft = UDim.new(0, 10)
                textPadding.PaddingRight = UDim.new(0, 25)
                
                local uc_drop = Instance.new("UICorner", dropdownButton)
                uc_drop.CornerRadius = Theme.Sizes.SmallRadius
    
                local arrow = Instance.new("ImageLabel", dropdownButton)
                arrow.BackgroundTransparency = 1
                arrow.AnchorPoint = Vector2.new(0.5, 0.5)
                arrow.Position = UDim2.new(1, -15, 0.5, 0)
                arrow.Size = UDim2.new(0, 12, 0, 12)
                arrow.Image = "rbxassetid://3926305904"
                arrow.ImageColor3 = Theme.Colors.Text
    
                local optionsFrame = Instance.new("Frame")
                optionsFrame.Name = "OptionsFrame"
                optionsFrame.Parent = dropdown
                optionsFrame.BackgroundColor3 = Theme.Colors.SectionBack
                optionsFrame.BorderSizePixel = 0
                optionsFrame.Position = UDim2.new(0.5, 0, 1, 5) 
                optionsFrame.AnchorPoint = Vector2.new(0, 0)
                optionsFrame.Size = UDim2.new(0.5, 0, 0, 0) 
                optionsFrame.Visible = false
                optionsFrame.ZIndex = 20
                optionsFrame.ClipsDescendants = true
                
                local uc_options = Instance.new("UICorner", optionsFrame)
                uc_options.CornerRadius = Theme.Sizes.SmallRadius

                local searchContainer = Instance.new("Frame")
                searchContainer.Name = "SearchContainer"
                searchContainer.Parent = optionsFrame
                searchContainer.BackgroundColor3 = Theme.Colors.ElementBack
                searchContainer.Position = UDim2.new(0, 5, 0, 5)
                searchContainer.Size = UDim2.new(1, -10, 0, 25)
                searchContainer.ZIndex = 21
                local uc_search = Instance.new("UICorner", searchContainer)
                uc_search.CornerRadius = Theme.Sizes.SmallRadius

                local searchIcon = Instance.new("ImageLabel")
                searchIcon.Name = "SearchIcon"
                searchIcon.Parent = searchContainer
                searchIcon.BackgroundTransparency = 1
                searchIcon.Size = UDim2.new(0, 14, 0, 14)
                searchIcon.Position = UDim2.new(0, 6, 0.5, 0)
                searchIcon.AnchorPoint = Vector2.new(0, 0.5)
                searchIcon.Image = "rbxassetid://5036466001"
                searchIcon.ImageColor3 = Theme.Colors.Text
                searchIcon.ZIndex = 22

                local searchBar = Instance.new("TextBox")
                searchBar.Name = "SearchBar"
                searchBar.Parent = searchContainer
                searchBar.BackgroundTransparency = 1
                searchBar.Position = UDim2.new(0, 26, 0, 0)
                searchBar.Size = UDim2.new(1, -30, 1, 0)
                searchBar.Font = Theme.Fonts.Body
                searchBar.PlaceholderText = "Search..."
                searchBar.Text = ""
                searchBar.TextColor3 = Theme.Colors.Text
                searchBar.TextSize = 14
                searchBar.TextXAlignment = Enum.TextXAlignment.Left
                searchBar.ZIndex = 22

                local scrollingList = Instance.new("ScrollingFrame")
                scrollingList.Name = "ScrollingList"
                scrollingList.Parent = optionsFrame
                scrollingList.BackgroundTransparency = 1
                scrollingList.Position = UDim2.new(0, 0, 0, 35)
                scrollingList.Size = UDim2.new(1, 0, 1, -35)
                scrollingList.AutomaticCanvasSize = Enum.AutomaticSize.Y
                scrollingList.CanvasSize = UDim2.new(0, 0, 0, 0)
                scrollingList.ScrollBarThickness = 2
                scrollingList.ScrollBarImageTransparency = 0.5
                scrollingList.ScrollBarImageColor3 = Theme.Colors.Text
                scrollingList.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left
                scrollingList.ZIndex = 35

                local listLayout = Instance.new("UIListLayout", scrollingList)
                listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
                local outsideClickListener, positionUpdaterConnection
                local function toggleDropdown(isOpen)
                    if isOpen then
                        local main = dropdown:FindFirstAncestor("main")
                        outsideClickListener = UserInputService.InputBegan:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 and optionsFrame.Visible then
                                local mousePos = input.Position
                                local inOptions = (mousePos.X >= optionsFrame.AbsolutePosition.X and mousePos.X <= optionsFrame.AbsolutePosition.X + optionsFrame.AbsoluteSize.X and mousePos.Y >= optionsFrame.AbsolutePosition.Y and mousePos.Y <= optionsFrame.AbsolutePosition.Y + optionsFrame.AbsoluteSize.Y)
                                local inButton = (mousePos.X >= dropdownButton.AbsolutePosition.X and mousePos.X <= dropdownButton.AbsolutePosition.X + dropdownButton.AbsoluteSize.X and mousePos.Y >= dropdownButton.AbsolutePosition.Y and mousePos.Y <= dropdownButton.AbsolutePosition.Y + dropdownButton.AbsoluteSize.Y)
                                
                                local clickedOutside = not inOptions and not inButton
                                
                                if clickedOutside then toggleDropdown(false) end
                            end
                        end)
    
                        optionsFrame.ZIndex = 22
                        optionsFrame.Parent = scrgui 
                        optionsFrame.Position = UDim2.new(0, dropdownButton.AbsolutePosition.X, 0, dropdownButton.AbsolutePosition.Y + dropdownButton.AbsoluteSize.Y + 5)
     
                        optionsFrame.Size = UDim2.new(0, dropdownButton.AbsoluteSize.X, 0, 0)
                        optionsFrame.Visible = true

                        for i, v in ipairs(scrollingList:GetChildren()) do
                            if v:IsA("TextButton") then
                                local textLabel = v:FindFirstChildWhichIsA("TextLabel")
                                local checkmark = v:FindFirstChild("Checkmark")
                                
                                v.BackgroundTransparency = 1
                                if textLabel then textLabel.TextTransparency = 1 end
                                if checkmark then checkmark.BackgroundTransparency = 1 end
                                
                                task.delay(0.05 + (i * 0.02), function()
                                    if optionsFrame.Visible then
                                        local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                                        TweenService:Create(v, tweenInfo, {BackgroundTransparency = 0}):Play()
                                        if textLabel then TweenService:Create(textLabel, tweenInfo, {TextTransparency = 0}):Play() end
                                        if checkmark then TweenService:Create(checkmark, tweenInfo, {BackgroundTransparency = 0}):Play() end
                                    end
                                end)
                            end
                        end

                        TweenService:Create(optionsFrame, TweenInfo.new(0.2), {Size = UDim2.new(0, dropdownButton.AbsoluteSize.X, 0, 160)}):Play()
                        TweenService:Create(arrow, TweenInfo.new(0.2), {Rotation = 180}):Play()
    
                        if main then
                            positionUpdaterConnection = main:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
                                if optionsFrame.Visible then
                                    optionsFrame.Position = UDim2.new(0, dropdownButton.AbsolutePosition.X, 0, dropdownButton.AbsolutePosition.Y + dropdownButton.AbsoluteSize.Y + 5)
                                end
                            end)
                        end
                    else
                        if outsideClickListener then
                            outsideClickListener:Disconnect()
                            outsideClickListener = nil
                        end
                        if positionUpdaterConnection then
                            positionUpdaterConnection:Disconnect()
                            positionUpdaterConnection = nil
                        end
    
                        optionsFrame.ZIndex = 23
                        TweenService:Create(arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
                        local tween = TweenService:Create(optionsFrame, TweenInfo.new(0.2), {Size = UDim2.new(0, dropdownButton.AbsoluteSize.X, 0, 0)})
                        tween.Completed:Connect(function() 
                            optionsFrame.Visible = false
                            optionsFrame.Parent = dropdown 
                        end)
                        tween:Play()
                    end
                end
    
                local function UpdateOptions(newList)
                    for _, child in pairs(scrollingList:GetChildren()) do
                        if child:IsA("TextButton") then child:Destroy() end
                    end
                    for _, optionName in ipairs(newList) do
                    local optionButton = Instance.new("TextButton")
                    optionButton.Name = optionName
                    optionButton.Parent = scrollingList
                    optionButton.BackgroundColor3 = Theme.Colors.ElementBack
                    optionButton.Size = UDim2.new(1, 0, 0, 30)
                    optionButton.BorderSizePixel = 0
                    optionButton.Text = ""
                    optionButton.ZIndex = 9
    
                    local checkmark = Instance.new("Frame", optionButton)
                    checkmark.Name = "Checkmark"
                    checkmark.BackgroundColor3 = Theme.Colors.Primary
                    checkmark.BorderSizePixel = 0
                    checkmark.Size = UDim2.new(0, 8, 0, 8)
                    checkmark.Position = UDim2.new(0, 15, 0.5, -4)
                    checkmark.Visible = false
                    CollectionService:AddTag(checkmark, "Theme_Primary_BackgroundColor3")
                    checkmark.ZIndex = 24
                    local uc_check = Instance.new("UICorner", checkmark)
                    uc_check.CornerRadius = UDim.new(1, 0)
                    
                    local textLabel = Instance.new("TextLabel", optionButton)
                    textLabel.BackgroundTransparency = 1
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.Font = Theme.Fonts.Body
                    textLabel.Text = optionName
                    textLabel.TextColor3 = Theme.Colors.Text
                    textLabel.TextSize = 14
                    textLabel.TextXAlignment = Enum.TextXAlignment.Left
                    textLabel.ZIndex = 24 
    
                    local padding = Instance.new("UIPadding", textLabel)
                    padding.PaddingLeft = UDim.new(0, 30)
    
                    optionButton.AutoButtonColor = false
    
                    local function handleSelect()
                        if isMultiSelect then
                            selectedItems[optionName] = not selectedItems[optionName]
                            checkmark.Visible = selectedItems[optionName]
    
                            local result = {}
                            for _, item in ipairs(newList) do
                                if selectedItems[item] then table.insert(result, item) end
                            end
    
                            if #result > 0 then
                                dropdownButton.Text = table.concat(result, ", ")
                            else
                                dropdownButton.Text = "Select"
                            end
    
                            if callback then
                                callback(result)
                            end
                        else
                            dropdownButton.Text = optionName
                            toggleDropdown(false)
                            if callback then callback(optionName) end
                        end
                    end
    
                    optionButton.MouseButton1Click:Connect(handleSelect)
                    optionButton.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Touch then
                            handleSelect()
                        end
                    end)
                    
                    optionButton.MouseEnter:Connect(function() optionButton.BackgroundColor3 = Theme.Colors.Hover end)
                    optionButton.MouseLeave:Connect(function() optionButton.BackgroundColor3 = Theme.Colors.ElementBack end)
                end
                end

                searchBar:GetPropertyChangedSignal("Text"):Connect(function()
                    local text = searchBar.Text:lower()
                    for _, button in ipairs(scrollingList:GetChildren()) do
                        if button:IsA("TextButton") then
                            if button.Name:lower():find(text, 1, true) then
                                button.Visible = true
                            else
                                button.Visible = false
                            end
                        end
                    end
                end)

                UpdateOptions(list)
    
                local function handleDropdownToggle()
                    toggleDropdown(not optionsFrame.Visible)
                    for _, button in ipairs(scrollingList:GetChildren()) do
                        if button:IsA("TextButton") and button:FindFirstChild("Checkmark") then
                            button.Checkmark.Visible = (isMultiSelect and selectedItems[button.Name]) or (dropdownButton.Text == button.Name)
                        end
                    end
                end

                dropdownButton.MouseButton1Click:Connect(handleDropdownToggle)
                dropdownButton.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.Touch then
                        handleDropdownToggle()
                    end
                end)

                local api = {}
                function api:Refresh(newList, keepSelection)
                    if not keepSelection then
                        selectedItems = {}
                        dropdownButton.Text = (isMultiSelect and "Select") or (newList[1] or "Select")
                    end
                    UpdateOptions(newList)
                end
                return api
            end

            return section
        end

        function sec:Header(name)
            layoutOrderCounter = layoutOrderCounter + 1
            local headerFrame = Instance.new("Frame")
            headerFrame.Name = "header"
            headerFrame.Parent = workareamain
            headerFrame.BackgroundTransparency = 1
            headerFrame.Size = UDim2.new(1, 0, 0, 40)
            headerFrame.LayoutOrder = layoutOrderCounter

            local headerLabel = Instance.new("TextLabel")
            headerLabel.Name = "HeaderLabel"
            headerLabel.Parent = headerFrame
            headerLabel.BackgroundTransparency = 1
            headerLabel.Size = UDim2.new(1, 0, 1, 0)
            headerLabel.Position = UDim2.new(0, 0, 0, 0)
            headerLabel.Font = Theme.Fonts.Title
            headerLabel.Text = name
            headerLabel.TextColor3 = Theme.Colors.TextDark
            headerLabel.TextSize = 24
            headerLabel.TextXAlignment = Enum.TextXAlignment.Left
            headerLabel.TextYAlignment = Enum.TextYAlignment.Center
            headerLabel.ZIndex = 2

            layoutOrderCounter = layoutOrderCounter + 1
            local padding = Instance.new("Frame")
            padding.Name = "padding"
            padding.Parent = workareamain
            padding.BackgroundTransparency = 1
            padding.Size = UDim2.new(1, 0, 0, 8)
            padding.LayoutOrder = layoutOrderCounter
        end
        
        function sec:Button(text, callback)
            layoutOrderCounter = layoutOrderCounter + 1
            local button = Instance.new("TextButton")
            button.Name = "button"
            button.Parent = workareamain
            button.BackgroundColor3 = Theme.Colors.LightGray
            button.Size = UDim2.new(1, 0, 0, 37)
            button.BackgroundColor3 = Theme.Colors.ElementBack
            button.Size = UDim2.new(1, 0, 0, 32)
            button.ZIndex = 2
            button.Font = Theme.Fonts.Body
            button.Text = text or "Button"
            button.TextColor3 = Theme.Colors.Text
            button.TextSize = 14
            button.AutoButtonColor = false
            button.LayoutOrder = layoutOrderCounter

            local uc_3 = Instance.new("UICorner")
            uc_3.CornerRadius = Theme.Sizes.SmallRadius
            uc_3.Parent = button

            button.MouseEnter:Connect(function()
                TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = Theme.Colors.Hover}):Play()
            end)

            button.MouseLeave:Connect(function()
                TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = Theme.Colors.ElementBack}):Play()
            end)

            if callback then
                button.MouseButton1Click:Connect(function()
                    TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Colors.Primary}):Play()
                    task.wait(0.1)
                    TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Colors.ElementBack}):Play()
                    task.spawn(callback)
                end)
            end
        end

        function sec:Label(name)
            layoutOrderCounter = layoutOrderCounter + 1
            local label = Instance.new("TextLabel")
            label.Name = "label"
            label.Parent = workareamain
            label.BackgroundTransparency = 1
            label.Size = UDim2.new(1, 0, 0, 37)
            label.Font = Theme.Fonts.Body
            label.TextColor3 = Theme.Colors.Text
            label.TextSize = 14
            label.TextWrapped = true
            label.Text = name
            label.LayoutOrder = layoutOrderCounter
            label.TextXAlignment = Enum.TextXAlignment.Left
        end


        function sec:Switch(text, default, callback)
            layoutOrderCounter = layoutOrderCounter + 1
            local toggled = default or false
            
            local ToggleFrame = Instance.new("TextButton")
            ToggleFrame.Name = "toggleswitch"
            ToggleFrame.Parent = workareamain
            ToggleFrame.BackgroundColor3 = Theme.Colors.ElementBack
            ToggleFrame.Size = UDim2.new(1, 0, 0, 32)
            ToggleFrame.AutoButtonColor = false
            ToggleFrame.Text = ""
            ToggleFrame.LayoutOrder = layoutOrderCounter
            local corner = Instance.new("UICorner", ToggleFrame)
            corner.CornerRadius = Theme.Sizes.SmallRadius

            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Parent = ToggleFrame
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
            ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
            ToggleLabel.Font = Theme.Fonts.Body
            ToggleLabel.Text = text or "Switch"
            ToggleLabel.TextColor3 = Theme.Colors.Text
            ToggleLabel.TextSize = 14
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left

            local ToggleIndicator = Instance.new("Frame")
            ToggleIndicator.Parent = ToggleFrame
            ToggleIndicator.AnchorPoint = Vector2.new(1, 0.5)
            ToggleIndicator.BackgroundColor3 = toggled and Theme.Colors.Primary or Theme.Colors.ContentBack
            ToggleIndicator.Position = UDim2.new(1, -10, 0.5, 0)
            ToggleIndicator.Size = UDim2.new(0, 36, 0, 18)
            local indCorner = Instance.new("UICorner", ToggleIndicator)
            indCorner.CornerRadius = UDim.new(1,0)
            local indStroke = Instance.new("UIStroke", ToggleIndicator)
            indStroke.Color = Theme.Colors.Border
            indStroke.Thickness = 1
            indStroke.Parent = ToggleIndicator

            local ToggleCircle = Instance.new("Frame")
            ToggleCircle.Parent = ToggleIndicator
            ToggleCircle.BackgroundColor3 = Theme.Colors.Text
            ToggleCircle.Size = UDim2.new(0, 14, 0, 14)
            local circScale = Instance.new("UIScale", ToggleCircle)

            local circCorner = Instance.new("UICorner", ToggleCircle)
            circCorner.CornerRadius = UDim.new(1,0)

            local offPos = UDim2.new(0, 2, 0.5, 0)
            local onPos = UDim2.new(0, 20, 0, 2)
            ToggleCircle.Position = toggled and onPos or UDim2.new(0, 2, 0, 2)
            ToggleCircle.AnchorPoint = Vector2.new(0, 0)

            ToggleFrame.MouseButton1Click:Connect(function()
                toggled = not toggled
                local targetColor = toggled and Theme.Colors.Primary or Theme.Colors.ContentBack
                local targetPos = toggled and onPos or UDim2.new(0, 2, 0, 2)

                local mainTweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
                local scaleTweenInfo = TweenInfo.new(mainTweenInfo.Time / 2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)

                TweenService:Create(ToggleIndicator, mainTweenInfo, {BackgroundColor3 = targetColor}):Play()
                TweenService:Create(ToggleCircle, mainTweenInfo, {Position = targetPos}):Play()

                local scaleTween1 = TweenService:Create(circScale, scaleTweenInfo, {Scale = 1.2})
                scaleTween1.Completed:Connect(function()
                    TweenService:Create(circScale, scaleTweenInfo, {Scale = 1}):Play()
                end)
                scaleTween1:Play()

                if callback then
                    task.spawn(callback, toggled)
                end
            end)
        end


        function sec:TextField(text, placeholder, callback)
            layoutOrderCounter = layoutOrderCounter + 1
            
            local textfield = Instance.new("TextLabel")
            textfield.Name = "textfield"
            textfield.Parent = workareamain
            textfield.BackgroundTransparency = 1
            textfield.Size = UDim2.new(1, 0, 0, 37)
            textfield.Font = Theme.Fonts.Body
            textfield.Text = text
            textfield.TextColor3 = Theme.Colors.Text
            textfield.TextSize = 14
            textfield.TextWrapped = true
            textfield.TextXAlignment = Enum.TextXAlignment.Left
            textfield.LayoutOrder = layoutOrderCounter
            
            local Frame_2 = Instance.new("Frame")
            Frame_2.Parent = textfield
            Frame_2.BackgroundColor3 = Theme.Colors.LightGray
            Frame_2.BackgroundColor3 = Theme.Colors.ElementBack

            Frame_2.Position = UDim2.new(0.5, 0, 0.5, 0)
            Frame_2.AnchorPoint = Vector2.new(0, 0.5)
            Frame_2.Size = UDim2.new(0.5, 0, 1, -6)

            local uc_6 = Instance.new("UICorner")
            uc_6.CornerRadius = Theme.Sizes.SmallRadius
            uc_6.Parent = Frame_2

            local TextBox = Instance.new("TextBox")
            TextBox.Parent = Frame_2
            TextBox.BackgroundTransparency = 1
            TextBox.BorderSizePixel = 0
            TextBox.ClipsDescendants = true
            TextBox.Position = UDim2.new(0, 10, 0, 0)
            TextBox.Size = UDim2.new(1, -20, 1, 0)
            TextBox.ClearTextOnFocus = false
            TextBox.Font = Theme.Fonts.Body
            TextBox.PlaceholderColor3 = Theme.Colors.TextDark
            TextBox.PlaceholderText = placeholder or "Type here..."
            TextBox.Text = ""
            TextBox.TextColor3 = Theme.Colors.Text
            TextBox.TextSize = 14
            TextBox.TextXAlignment = Enum.TextXAlignment.Left

            if callback then
                TextBox.FocusLost:Connect(function(enterPressed)
                    if enterPressed then
                        callback(TextBox.Text)
                    end
                end)
            end
        end


        function sec:Slider(text, min, max, default, callback)
            layoutOrderCounter = layoutOrderCounter + 1
            
            local sliderContainer = Instance.new("TextLabel")
            sliderContainer.Name = "slider"
            sliderContainer.Parent = workareamain
            sliderContainer.BackgroundTransparency = 1
            sliderContainer.Size = UDim2.new(1, 0, 0, 50)
            sliderContainer.Font = Theme.Fonts.Body
            sliderContainer.Text = text or "Slider"
            sliderContainer.TextColor3 = Theme.Colors.Text
            sliderContainer.TextSize = 14
            sliderContainer.TextWrapped = true
            sliderContainer.TextXAlignment = Enum.TextXAlignment.Left
            sliderContainer.LayoutOrder = layoutOrderCounter

            local valueLabel = Instance.new("TextLabel")
            valueLabel.Name = "ValueLabel"
            valueLabel.Parent = sliderContainer
            valueLabel.BackgroundTransparency = 1
            valueLabel.Font = Theme.Fonts.Body
            valueLabel.TextColor3 = Theme.Colors.Text
            valueLabel.TextSize = 14
            valueLabel.TextXAlignment = Enum.TextXAlignment.Right

            valueLabel.Position = UDim2.new(0.5, 0, 0, 0)
            valueLabel.AnchorPoint = Vector2.new(0, 0)
            valueLabel.Size = UDim2.new(0.5, 0, 0, 20)

            local track = Instance.new("Frame")
            track.Name = "Track"
            track.Parent = sliderContainer
            track.BackgroundColor3 = Theme.Colors.LightGray
            track.BackgroundColor3 = Theme.Colors.ElementBack

            track.Position = UDim2.new(0.5, 0, 0.6, 0)
            track.AnchorPoint = Vector2.new(0, 0)
            track.Size = UDim2.new(0.5, 0, 0, 6)
            local trackCorner = Instance.new("UICorner", track)
            trackCorner.CornerRadius = Theme.Sizes.FullRadius

            local fill = Instance.new("Frame")
            fill.Name = "Fill"
            fill.Parent = track
            fill.BackgroundColor3 = Theme.Colors.Primary
            fill.Size = UDim2.new(0, 0, 1, 0)
            local fillCorner = Instance.new("UICorner", fill)
            fillCorner.CornerRadius = Theme.Sizes.FullRadius
            

            createGradient(fill, Theme.Colors.Primary, Theme.Colors.PrimaryLight)

            local thumb = Instance.new("TextButton")
            thumb.Name = "Thumb"
            thumb.Parent = track
            thumb.BackgroundColor3 = Theme.Colors.TextLight
            thumb.Size = UDim2.new(0, 16, 0, 16)
            thumb.AnchorPoint = Vector2.new(0.5, 0.5)
            thumb.Position = UDim2.new(0, 0, 0.5, 0)
            thumb.ZIndex = 3
            thumb.Text = ""
            local thumbCorner = Instance.new("UICorner", thumb)
            thumbCorner.CornerRadius = Theme.Sizes.FullRadius
            local thumbStroke = Instance.new("UIStroke", thumb)
            thumbStroke.Color = Theme.Colors.Gray
            thumbStroke.Thickness = 1

            local currentValue = default or (min or 0)

            local function updateSlider(value, runCallback)
                local v_min = min or 0
                local v_max = max or 100
                currentValue = math.clamp(value, v_min, v_max)
                local percentage = (currentValue - v_min) / (v_max - v_min)
                
                valueLabel.Text = tostring(math.floor(currentValue * 100) / 100) 
                
                local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                TweenService:Create(fill, tweenInfo, {Size = UDim2.new(percentage, 0, 1, 0)}):Play()
                TweenService:Create(thumb, tweenInfo, {Position = UDim2.new(percentage, 0, 0.5, 0)}):Play()

                if runCallback and callback then
                    task.spawn(callback, currentValue)
                end
            end

            thumb.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    local moveConn, releaseConn
                    moveConn = UserInputService.InputChanged:Connect(function(moveInput)
                        local v_min = min or 0
                        local v_max = max or 100
                        local percentage = (moveInput.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
                        local newValue = v_min + (v_max - v_min) * math.clamp(percentage, 0, 1)
                        updateSlider(newValue, true)
                    end)
                    releaseConn = UserInputService.InputEnded:Connect(function()
                        moveConn:Disconnect()
                        releaseConn:Disconnect()
                    end)
                end
            end)

            updateSlider(currentValue, false)
        end

        function sec:Dropdown(name, list, multi, p4, p5)
            local defaultValue, callback
            if type(p4) == 'function' and p5 == nil then
                defaultValue = nil
                callback = p4
            else
                defaultValue = p4
                callback = p5
            end

            layoutOrderCounter = layoutOrderCounter + 1
            local dropdown = Instance.new("TextLabel")
            dropdown.Name = "dropdown"
            dropdown.Parent = workareamain
            dropdown.BackgroundTransparency = 1
            dropdown.Size = UDim2.new(1, 0, 0, 37)
            dropdown.Font = Theme.Fonts.Body
            dropdown.Text = name
            dropdown.TextColor3 = Theme.Colors.Text
            dropdown.TextSize = 14
            dropdown.TextXAlignment = Enum.TextXAlignment.Left
            dropdown.LayoutOrder = layoutOrderCounter

            local selectedItems = {}
            local isMultiSelect = multi or false

            if isMultiSelect and type(defaultValue) == "table" then
                for _, v in pairs(defaultValue) do
                    selectedItems[v] = true
                end
            end

            local dropdownButton = Instance.new("TextButton")
            dropdownButton.Name = "DropdownButton"
            dropdownButton.Parent = dropdown
            dropdownButton.BackgroundColor3 = Theme.Colors.LightGray
            dropdownButton.Parent = dropdown            
            dropdownButton.BackgroundColor3 = Theme.Colors.ElementBack
            dropdownButton.Position = UDim2.new(0.5, 0, 0.5, 0)
            dropdownButton.AnchorPoint = Vector2.new(0, 0.5)
            dropdownButton.Size = UDim2.new(0.5, 0, 1, -6)
            dropdownButton.Font = Theme.Fonts.Body
            dropdownButton.Text = (isMultiSelect and "Select") or (defaultValue or list[1] or "Select")
            if isMultiSelect and type(defaultValue) == "table" and #defaultValue > 0 then
                dropdownButton.Text = table.concat(defaultValue, ", ")
            else
                dropdownButton.Text = (not isMultiSelect and (defaultValue or list[1])) or "Select"
            end
            dropdownButton.TextColor3 = Theme.Colors.Text
            dropdownButton.TextSize = 14
            dropdownButton.ZIndex = 8
            dropdownButton.TextXAlignment = Enum.TextXAlignment.Left
            dropdownButton.TextTruncate = Enum.TextTruncate.AtEnd

            local textPadding = Instance.new("UIPadding", dropdownButton)
            textPadding.PaddingLeft = UDim.new(0, 10)
            textPadding.PaddingRight = UDim.new(0, 25)
            
            local uc_drop = Instance.new("UICorner", dropdownButton)
            uc_drop.CornerRadius = Theme.Sizes.SmallRadius

            local arrow = Instance.new("ImageLabel", dropdownButton)
            arrow.BackgroundTransparency = 1
            arrow.AnchorPoint = Vector2.new(0.5, 0.5)
            arrow.Position = UDim2.new(1, -15, 0.5, 0)
            arrow.Size = UDim2.new(0, 12, 0, 12)
            arrow.Image = "rbxassetid://3926305904"
            arrow.ImageColor3 = Theme.Colors.Text

            local optionsFrame = Instance.new("Frame")

            optionsFrame.Name = "OptionsFrame"
            optionsFrame.Parent = dropdown
            optionsFrame.BackgroundColor3 = Theme.Colors.SectionBack
            optionsFrame.BorderSizePixel = 0

            optionsFrame.Position = UDim2.new(0.5, 0, 1, 5) 
            optionsFrame.AnchorPoint = Vector2.new(0, 0)
            optionsFrame.Size = UDim2.new(0.5, 0, 0, 0) 
            optionsFrame.Visible = false
            optionsFrame.ZIndex = 20
            optionsFrame.ClipsDescendants = true
            

            local uc_options = Instance.new("UICorner", optionsFrame)
            uc_options.CornerRadius = Theme.Sizes.SmallRadius

            local searchContainer = Instance.new("Frame")
            searchContainer.Name = "SearchContainer"
            searchContainer.Parent = optionsFrame
            searchContainer.BackgroundColor3 = Theme.Colors.ElementBack
            searchContainer.Position = UDim2.new(0, 5, 0, 5)
            searchContainer.Size = UDim2.new(1, -10, 0, 25)
            searchContainer.ZIndex = 21
            local uc_search = Instance.new("UICorner", searchContainer)
            uc_search.CornerRadius = Theme.Sizes.SmallRadius

            local searchIcon = Instance.new("ImageLabel")
            searchIcon.Name = "SearchIcon"
            searchIcon.Parent = searchContainer
            searchIcon.BackgroundTransparency = 1
            searchIcon.Size = UDim2.new(0, 14, 0, 14)
            searchIcon.Position = UDim2.new(0, 6, 0.5, 0)
            searchIcon.AnchorPoint = Vector2.new(0, 0.5)
            searchIcon.Image = "rbxassetid://5036466001"
            searchIcon.ImageColor3 = Theme.Colors.Text
            searchIcon.ZIndex = 22

            local searchBar = Instance.new("TextBox")
            searchBar.Name = "SearchBar"
            searchBar.Parent = searchContainer
            searchBar.BackgroundTransparency = 1
            searchBar.Position = UDim2.new(0, 26, 0, 0)
            searchBar.Size = UDim2.new(1, -30, 1, 0)
            searchBar.Font = Theme.Fonts.Body
            searchBar.PlaceholderText = "Search..."
            searchBar.Text = ""
            searchBar.TextColor3 = Theme.Colors.Text
            searchBar.TextSize = 14
            searchBar.TextXAlignment = Enum.TextXAlignment.Left
            searchBar.ZIndex = 22

            local scrollingList = Instance.new("ScrollingFrame")
            scrollingList.Name = "ScrollingList"
            scrollingList.Parent = optionsFrame
            scrollingList.BackgroundTransparency = 1
            scrollingList.Position = UDim2.new(0, 0, 0, 35)
            scrollingList.Size = UDim2.new(1, 0, 1, -35)
            scrollingList.AutomaticCanvasSize = Enum.AutomaticSize.Y
            scrollingList.CanvasSize = UDim2.new(0, 0, 0, 0)
            scrollingList.ScrollBarThickness = 8
            scrollingList.ScrollBarImageTransparency = 0
            scrollingList.ScrollBarImageColor3 = Theme.Colors.Text
            scrollingList.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left
            scrollingList.ZIndex = 35

            local listLayout = Instance.new("UIListLayout", scrollingList)
            listLayout.SortOrder = Enum.SortOrder.LayoutOrder

            local outsideClickListener, positionUpdaterConnection
            local function toggleDropdown(isOpen)
                if isOpen then
                    local main = dropdown:FindFirstAncestor("main")
                    outsideClickListener = UserInputService.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 and optionsFrame.Visible then
                            local mousePos = input.Position
                            local inOptions = (mousePos.X >= optionsFrame.AbsolutePosition.X and mousePos.X <= optionsFrame.AbsolutePosition.X + optionsFrame.AbsoluteSize.X and mousePos.Y >= optionsFrame.AbsolutePosition.Y and mousePos.Y <= optionsFrame.AbsolutePosition.Y + optionsFrame.AbsoluteSize.Y)
                            local inButton = (mousePos.X >= dropdownButton.AbsolutePosition.X and mousePos.X <= dropdownButton.AbsolutePosition.X + dropdownButton.AbsoluteSize.X and mousePos.Y >= dropdownButton.AbsolutePosition.Y and mousePos.Y <= dropdownButton.AbsolutePosition.Y + dropdownButton.AbsoluteSize.Y)
                            
                            local clickedOutside = not inOptions and not inButton
                            
                            if clickedOutside then toggleDropdown(false) end
                        end
                    end)

                    optionsFrame.ZIndex = 22
                    optionsFrame.Parent = scrgui 
                    optionsFrame.Position = UDim2.new(0, dropdownButton.AbsolutePosition.X, 0, dropdownButton.AbsolutePosition.Y + dropdownButton.AbsoluteSize.Y + 5)
 
                    optionsFrame.Size = UDim2.new(0, dropdownButton.AbsoluteSize.X, 0, 0)
                    optionsFrame.Visible = true

                    for i, v in ipairs(scrollingList:GetChildren()) do
                        if v:IsA("TextButton") then
                            local textLabel = v:FindFirstChildWhichIsA("TextLabel")
                            local checkmark = v:FindFirstChild("Checkmark")
                            
                            v.BackgroundTransparency = 1
                            if textLabel then textLabel.TextTransparency = 1 end
                            if checkmark then checkmark.BackgroundTransparency = 1 end
                            
                            task.delay(0.05 + (i * 0.02), function()
                                if optionsFrame.Visible then
                                    local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                                    TweenService:Create(v, tweenInfo, {BackgroundTransparency = 0}):Play()
                                    if textLabel then TweenService:Create(textLabel, tweenInfo, {TextTransparency = 0}):Play() end
                                    if checkmark then TweenService:Create(checkmark, tweenInfo, {BackgroundTransparency = 0}):Play() end
                                end
                            end)
                        end
                    end

                    TweenService:Create(optionsFrame, TweenInfo.new(0.2), {Size = UDim2.new(0, dropdownButton.AbsoluteSize.X, 0, 160)}):Play()
                    TweenService:Create(arrow, TweenInfo.new(0.2), {Rotation = 180}):Play()

                    if main then
                        positionUpdaterConnection = main:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
                            if optionsFrame.Visible then
                                optionsFrame.Position = UDim2.new(0, dropdownButton.AbsolutePosition.X, 0, dropdownButton.AbsolutePosition.Y + dropdownButton.AbsoluteSize.Y + 5)
                            end
                        end)
                    end
                else
                    if outsideClickListener then
                        outsideClickListener:Disconnect()
                        outsideClickListener = nil
                    end
                    if positionUpdaterConnection then
                        positionUpdaterConnection:Disconnect()
                        positionUpdaterConnection = nil
                    end

                    optionsFrame.ZIndex = 23
                    TweenService:Create(arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
                    local tween = TweenService:Create(optionsFrame, TweenInfo.new(0.2), {Size = UDim2.new(0, dropdownButton.AbsoluteSize.X, 0, 0)})
                    tween.Completed:Connect(function() 
                        optionsFrame.Visible = false
                        optionsFrame.Parent = dropdown 
                        if optionsFrame.Parent then
                            optionsFrame.Visible = false
                            optionsFrame.Parent = dropdown 
                        end
                    end)
                    tween:Play()
                end
            end

            local function UpdateOptions(newList)
                for _, child in pairs(scrollingList:GetChildren()) do
                    if child:IsA("TextButton") then child:Destroy() end
                end
                for _, optionName in ipairs(newList) do
                local optionButton = Instance.new("TextButton")
                optionButton.Name = optionName
                optionButton.Parent = scrollingList
                optionButton.BackgroundColor3 = Theme.Colors.ElementBack
                optionButton.Size = UDim2.new(1, 0, 0, 30)
                optionButton.BorderSizePixel = 0
                optionButton.Text = ""
                optionButton.ZIndex = 36

                local checkmark = Instance.new("Frame", optionButton)
                checkmark.Name = "Checkmark"
                checkmark.BackgroundColor3 = Theme.Colors.Primary
                checkmark.BorderSizePixel = 0
                checkmark.Size = UDim2.new(0, 8, 0, 8)
                checkmark.Position = UDim2.new(0, 15, 0.5, -4)
                checkmark.Visible = false
                checkmark.ZIndex = 24
                local uc_check = Instance.new("UICorner", checkmark)
                uc_check.CornerRadius = UDim.new(1, 0)
                
                local textLabel = Instance.new("TextLabel", optionButton)
                textLabel.BackgroundTransparency = 1
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.Font = Theme.Fonts.Body
                textLabel.Text = optionName
                textLabel.TextColor3 = Theme.Colors.Text
                textLabel.TextSize = 14
                textLabel.TextXAlignment = Enum.TextXAlignment.Left
                textLabel.ZIndex = 24 

                local padding = Instance.new("UIPadding", textLabel)
                padding.PaddingLeft = UDim.new(0, 30)

                optionButton.AutoButtonColor = false

                local function handleSelect()
                    if isMultiSelect then
                        selectedItems[optionName] = not selectedItems[optionName]
                        checkmark.Visible = selectedItems[optionName]

                        local result = {}
                        for _, item in ipairs(newList) do
                            if selectedItems[item] then table.insert(result, item) end
                        end

                        if #result > 0 then
                            dropdownButton.Text = table.concat(result, ", ")
                        else
                            dropdownButton.Text = "Select"
                        end

                        if callback then
                            callback(result)
                        end
                    else
                        dropdownButton.Text = optionName
                        toggleDropdown(false)
                        if callback then callback(optionName) end
                    end
                end

                optionButton.MouseButton1Click:Connect(handleSelect)
                optionButton.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.Touch then
                        handleSelect()
                    end
                end)
                
                optionButton.MouseEnter:Connect(function() optionButton.BackgroundColor3 = Theme.Colors.Hover end)
                optionButton.MouseLeave:Connect(function() optionButton.BackgroundColor3 = Theme.Colors.ElementBack end)
            end
            end

            searchBar:GetPropertyChangedSignal("Text"):Connect(function()
                local text = searchBar.Text:lower()
                for _, button in ipairs(scrollingList:GetChildren()) do
                    if button:IsA("TextButton") then
                        if button.Name:lower():find(text, 1, true) then
                            button.Visible = true
                        else
                            button.Visible = false
                        end
                    end
                end
            end)

            UpdateOptions(list)

            local function handleDropdownToggle()
                toggleDropdown(not optionsFrame.Visible)
                for _, button in ipairs(scrollingList:GetChildren()) do
                    if button:IsA("TextButton") and button:FindFirstChild("Checkmark") then
                        button.Checkmark.Visible = (isMultiSelect and selectedItems[button.Name]) or (dropdownButton.Text == button.Name)
                    end
                end
            end

            dropdownButton.MouseButton1Click:Connect(handleDropdownToggle)
            dropdownButton.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch then
                    handleDropdownToggle()
                end
            end)

            local api = {}
            function api:Refresh(newList, keepSelection)
                if not keepSelection then
                    selectedItems = {}
                    dropdownButton.Text = (isMultiSelect and "Select") or (newList[1] or "Select")
                end
                UpdateOptions(newList)
            end
            return api
        end

        sidebar2.MouseButton1Click:Connect(function()
            sectionIcon.Rotation = 0
            sectionIconScale.Scale = 0.6
            TweenService:Create(sectionIcon, TweenInfo.new(1.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Rotation = 360}):Play()
            TweenService:Create(sectionIconScale, TweenInfo.new(1.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Scale = 1}):Play()
            sec:Select()
        end)

        return sec
    end

    function window:OnSettingsClick(callback)
        settingsClickCallback = callback
    end

    function window:SetAccentColor(newColor)
        local oldPrimary = Theme.Colors.Primary
        local newLightColor = Color3.new(
            math.min(1, newColor.R * 1.2 + 0.1),
            math.min(1, newColor.G * 1.2 + 0.1),
            math.min(1, newColor.B * 1.2 + 0.1)
        )
        Theme.Colors.Primary = newColor
        Theme.Colors.PrimaryLight = newLightColor

        for _, instance in ipairs(CollectionService:GetTagged("Theme_Primary_BackgroundColor3") or {}) do
            if instance and instance.Parent then instance.BackgroundColor3 = newColor end
        end
        for _, instance in ipairs(CollectionService:GetTagged("Theme_Primary_ImageColor3") or {}) do
            if instance and instance.Parent then instance.ImageColor3 = newColor end
        end
        for _, instance in ipairs(CollectionService:GetTagged("Theme_Primary_BackgroundColor3_Switch") or {}) do
            if instance and instance.Parent and instance.BackgroundColor3 == oldPrimary then instance.BackgroundColor3 = newColor end
        end
        for _, instance in ipairs(CollectionService:GetTagged("Theme_Primary_Gradient") or {}) do
            if instance and instance.Parent and instance:IsA("UIGradient") then
                instance.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, newColor),
                    ColorSequenceKeypoint.new(1, newLightColor)
                })
            end
        end
    end

    return window
end

return lib
