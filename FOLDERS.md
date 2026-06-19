# Folder Structure — work + life on a fresh Mac

`setup.sh` offers to create this. The idea: **two roots**, separated by how they're
backed up and how you think about them.

- **`~/Developer`** — source code only. Local, versioned by git. **Never** in iCloud.
- **`~/Documents`** — everything else (work + life docs), organized by **PARA**.
  iCloud-syncable, so it follows you across devices.

Why split them: code in iCloud-synced Documents causes sync conflicts and chokes on
`node_modules`/build output. Keep code local + push to git remotes instead.

## The two trees

```
~/Developer/                     # source code (local + git, NOT iCloud)
├── work/                   # employer & client repos
├── personal/               # your own projects
├── oss/                    # open-source clones & forks
├── learning/               # courses, tutorials, katas
├── sandbox/                # throwaway spikes (delete freely)
└── archive/                # dormant repos you might revisit

~/Documents/                # work + life docs (PARA, iCloud-syncable)
├── 00-Inbox/               # dump zone — process to empty weekly
├── 01-Projects/            # active efforts WITH a finish line
├── 02-Areas/               # ongoing responsibilities, NO end date
│   ├── Career/
│   ├── Finances/
│   ├── Health/
│   ├── Home/
│   └── Personal/
├── 03-Resources/           # reference material & topics of interest
└── 04-Archive/             # finished / inactive items
```

Number prefixes (`00`–`04`) keep Finder sorted in the right order automatically.

## PARA in one minute

PARA (by Tiago Forte) organizes by **actionability**, not topic — that's the whole trick.

| Bucket | Question it answers | Examples (work) | Examples (life) |
|--------|---------------------|-----------------|-----------------|
| **Projects** | What am I actively pushing to a finish line? | "Ship v2.0", "Q3 board deck" | "Plan Japan trip", "Renew passport" |
| **Areas** | What do I maintain indefinitely? | "Team", "On-call" | "Finances", "Health", "Home", "Car" |
| **Resources** | What might I reference later? | API docs, design system | Recipes, workout plans, templates |
| **Archive** | What's done or dormant? | shipped projects | past trips, old leases |

Rule of thumb: a **Project** has a deadline and an end. An **Area** never ends. When a
Project finishes, drag it to `04-Archive`.

## Where do I put X?

| Thing | Goes in |
|-------|---------|
| A git repo | `~/Developer/<context>/` |
| A quick experiment | `~/Developer/sandbox/` |
| A signed contract, invoice | `~/Documents/02-Areas/Finances/` |
| Tax year docs | `~/Documents/02-Areas/Finances/Taxes/<year>/` |
| Medical records | `~/Documents/02-Areas/Health/` |
| A talk you're preparing | `~/Documents/01-Projects/<talk>/` |
| A PDF you saved to read later | `~/Documents/00-Inbox/` (then file or delete) |
| Reusable templates / boilerplate docs | `~/Documents/03-Resources/` |
| Last year's finished side project | `~/Developer/archive/` (code) + `~/Documents/04-Archive/` (docs) |

## Habits that keep it clean

- **`~/Downloads` is an inbox, not storage.** Empty it weekly — file or trash.
- **`00-Inbox` is the default landing spot** when you don't know where something goes.
  Process it weekly so it never grows.
- **Name dated files** `YYYY-MM-DD_name_vN` → `2026-06-19_invoice-acme_v2.pdf`.
- **kebab-case** for repo + folder names; one repo = one folder.
- **Finder Tags** (e.g. `Current`, `Waiting`, `Reference`) cut *across* PARA — tag a file
  in any bucket and find it via a **Smart Folder**.
- **Back up two ways**: Time Machine for `~/Documents`; **git remotes** for `~/Developer`
  (Time Machine alone is not a backup for code).

## macOS tips

- **Pin to Finder sidebar:** drag `~/Developer` and `~/Documents` into the sidebar.
- **Show your Library when needed:** in Finder, `Cmd+Shift+.` toggles hidden files.
- **Screenshots:** point them at one place so they don't litter the Desktop —
  `defaults write com.apple.screencapture location ~/Documents/00-Inbox && killall SystemUIServer`
  (or let Shottr/CleanShot manage them).

## Optional upgrades

- **Hammer icon (you have it):** because the root is `~/Developer`, macOS shows a
  hammer glyph on it (home-root only). Rename the root if you'd rather not have it.
- **Johnny.Decimal:** if PARA's `02-Areas` gets big, add J.D numbering inside it
  (`11 Finances`, `11.01 Taxes`, …) for stable, memorable addresses.

## Credits

- PARA — [Tiago Forte](https://fortelabs.com/blog/para/) ·
  [Todoist summary](https://www.todoist.com/productivity-methods/para-method)
- [Johnny.Decimal](https://johnnydecimal.com/)
- [`~/Developer` hammer icon](https://www.cocoadelica.co.uk/blog/default-folder-icon-in-macos)
