# **FiveTrolls** – The Ultimate Fun Script to Prank Your Friends in FiveM!

Want to spice up your FiveM server with some playful chaos? **FiveTrolls** is a light-hearted script designed for harmless fun and pranks. Whether you’re looking to mess with a friend or surprise the whole server, this script gives you the perfect tools to keep everyone guessing and laughing.

## Features:

* **/restrictspeed [id]**: Slow down your target by restricting their speed. Don’t provide an ID? You’ll restrict *everyone's* speed on the server!
* **/blowup [id]**: Play a bomb-timer sound that ends with a *real* explosion. Your friend won’t see it coming—until it’s too late!
* **/playsound [id]**: The same bomb-timer sound as **/blowup**, but this time it’s just a prank! Watch your friend brace for impact... only for nothing to happen.
* **/ragdoll [id]**: Make your friends ragdoll out of nowhere and watch as they hilariously flop around the map.
* **/kill [id]**: End it all with a quick command. One moment they're standing, the next they’ve been wiped out.
* **/mw [id]**: Spawn two (configurable) squads of angry Merryweather mercenaries to chase your friend. They won’t be able to outrun this crew! 

## Planned Features:

* **/yeet [id]**: Launch your friends high into the air. Gravity? Who needs it!
* **/transform [id]**: Ever feel like your friends are acting like clowns? Now, you can literally turn them into one. Honk honk!
* **/haunt [id]**: Unleash an army of clowns to chase down your friends. They won’t hurt you—they just want to point and laugh!

## Why Choose FiveTrolls?

With **FiveTrolls**, it’s all about having a good time with your friends. Whether you’re creating moments of panic with a fake bomb timer, or summoning Merryweather to hunt someone down, this script is designed for fun, harmless pranks that will leave everyone laughing.

Bring a little mischief to your server with **FiveTrolls**—because gaming with friends is always better with a little chaos!

# All these commands can be used through server console too!

## Installation

### Step 1: Download and Add the Resource to Your Server

1. Download the resource from the [GitHub release](https://github.com/OG-Redface/FiveTrolls/releases).
2. Extract the folder and place it inside your server's `resources` directory.


### Step 2: Add to Your `server.cfg`

1. Open your **server.cfg** file.
2. Add the following line to ensure the resource starts when the server starts:
```
ensure FiveTrolls
```

### Step 3: (Optional) Install **Badger_Discord_API**

If you want to allow command execution via **Discord Role IDs**, you'll need to install **Badger_Discord_API**:

1. Download **Badger_Discord_API** from the [official repository](https://github.com/JaredScar/Badger_Discord_API).
2. Add **Badger_Discord_API** to your server's `resources` directory.
3. Ensure **Badger_Discord_API** is started **before** FiveTrolls by adding these lines to your **server.cfg**:

```
ensure Badger_Discord_API
ensure FiveTrolls
```

> **Important**: Make sure **Badger_Discord_API** is started **before** FiveTrolls. If **Badger_Discord_API** is not installed or not running before FiveTrolls, the commands using **Role IDs** will not function correctly.

> **Note**: If you do not want to use **Role IDs**, leave the **AdminRoleID** in the config file as `"CHANGE_ME"` or empty, and only the **AdminUserID** will be used for command permissions.
