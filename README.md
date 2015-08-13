# The Disillusionist

_The Disillusionist_ is a web-based, narrative-heavy video game about a detective in a world where magic exists. If that sounds like your cup of tea, the most recent release is always hosted at [this project's GitHub.io page](http://arashikou.github.io/exper3-2015/). Just click on that link and you'll be playing. The game will automatically save after every action, so you can close the window and come back at any time to continue. Note that the game is saved to your computer, so your saved game will not follow you if you move to a different computer.

**As a noir-influenced story, this game contains content and themes that some people may find objectionable. It is not suitable for children.**

This game runs in a web browser. It has been tested in recent versions of Chrome and Firefox, and these are the recommended browsers. However, it _should_ work in the most recent versions of Internet Explorer and Safari as well. It will not work on versions of Internet Explorer lower than 11.

This game is designed to be played on a computer. It is not optimized for mobile and may fail to work or work poorly on your phone or tablet. My apologies, but I had to spend my limited time during EXPER3 wisely, and redesigning the UI for a second platform was not high on my list.

# EXPER3 2015

Last year, my wife gave me the best 30th birthday present I could have asked for by challenging me to make some real progress on my dream of making video games. She organized a themed video game jam, which she dubbed EXPER3, for which I had to make either a game a week for four weeks or one game in a month. You can read more about that and check out the results at [the GitHub repository where I checked in my entry](https://github.com/arashikou/exper3-2014).

Since that went so well, except for me continuing to make any more games once the jam was over, we decided to make this an annual event. EXPER3 ran from July 12<sup>th</sup> to August 12<sup>th</sup>, inclusive. For 2015, the theme was **ILLUSION**. _The Disillusionist_ is my entry.

# This Year's Game

This year, I have decided to make one game in a month instead of four games in four weeks. The reason is that last year, EXPER3 helped me rediscover my love of narrative in games, but I didn't really have a strong narrative in any of my creations because of time constraints. This year, I want to make something narrative, and that means taking more time. It also means the game will probably be less technically ambitious than it could otherwise be, as I want to focus on making the story solid.

I've decided to make what Sam Ashwell calls a ["Floating Module" game](https://heterogenoustasks.wordpress.com/2015/01/26/standard-patterns-in-choice-based-games/) or what Alexis Kennedy calls a ["Quality-Based Narrative"](http://www.failbettergames.com/storynexus-developer-diary-2-fewer-spreadsheets-less-swearing/). I really love _Fallen London_, and I've read nearly all of Kennedy's writings about the theory behind it. I think there's a lot of potential in this relatively novel form, and I want to explore it.

Unfortunately, every QBN engine out there has been formally or effectively abandoned by its creator. Even Failbetter's own [StoryNexus](http://storynexus.com/) has gone into maintenance mode after it failed to attract enough of an audience to fund its continued development. And while you can hack Twine to work, it's not a supremely user-friendly workflow. So I've decided to code my own framework for this game. I make no pretension that it will be general-purpose enough to work for other people, of course.

# How Can I Build It?

If you want to build the code for yourself, you'll need to have [node.js](https://nodejs.org/), [npm](https://www.npmjs.com/), and [gulp](http://gulpjs.com/) installed globally. (or at least somewhere your PATH can find them) All other dependencies will be downloaded to the project folder by npm and will not affect your system configuration. These steps should work on any operating system that has a node.js implementation.

After checking out the code, you'll want to use npm to install the dev-dependencies needed for compilation, which are numerous.

```bash
npm install
```

With that complete, you're all ready to compile! There are several gulp tasks configured, but the relevant ones are

```bash
gulp build
```

to compile all source code to the out/ directory.

```bash
gulp serve
```

to serve up the results from a local webserver that can be connected to on [localhost:8080](http://localhost:8080/). Note that this task will not terminate on its own and must be terminated (usually with CTRL-C or your OS's variant) when you are done.

Lastly, the default gulp task will build all sources and then serve them up while also watching for changes and rebuilding as necessary. Very useful for development, not so useful for just trying out the game.

# Technologies at Work

The game is written in the following languages:

* [CoffeeScript](http://coffeescript.org/)
* [Jade](http://jade-lang.com/)
* [Less](http://lesscss.org/)

It uses the following libraries:

* [AngularJS 1.4](https://angularjs.org/)
* [normalize.css 3.0.3](https://necolas.github.io/normalize.css/)

Dependency management is handled by [npm](https://www.npmjs.com/) and task running is handled by [gulp](http://gulpjs.com/), which both run on [node.js](https://nodejs.org/).
