### Installation

``
npm install && bower install
``

### Working Tree Structure:


```
less/elements.less --> all common usable less mixins
less/style.less --> all the styles goes here
less/variables.less --> all the styles configurable variables goes here

lib --> all vendors files(css & js)

images --> all images goes here

fonts --> all fonts goes here

coffee/behaviour/core.coffee --> main behaviour file
```

**Note:** Please make a coffee file for each widgets that has behaviour. Example
the button widget, buttons can have in-progress, disabled, focused behaviour so
you should put it on a coffee file name coffee/behaviour/button.coffee

**Note:** In creating coffee scripts, please make sure to wrap it with this:
``$(->`` and ``);``

**Note:** Please push for every works you have done, cause I need to review it.

Equivalent Links for less and coffee files

```
coffee/behaviour/core.coffee -> <script type="text/javascript" src="build/js/behaviour/core.js"></script>
less/style.less -> <link href="build/css/style.css" rel="stylesheet" />
```
