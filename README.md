UzysDragMenu
================

Drag Menu you can easily open and close using drag gesture.

![Screenshot](https://github.com/uzysjung/UzysDragMenu/raw/master/UzysDragMenu.png)  ![Screenshot](https://github.com/uzysjung/UzysDragMenu/raw/master/UzysDragMenu.gif)

**UzysDragMenu features:**

* Very Easy to customize menu view , you can use interface builder.  
* you can choose drag area (superView or MenuView), using Option : isSuperViewGesture
* Support Both ARC and non-ARC Project

## Installation
Copy over the files libary folder to your project folder

## Usage

Import header.

``` objective-c
#import "UzysDragMenu.h"
```

### Initialize
####1. make menu Item

``` objective-c
UzysDragMenuItem *item0 = [[UzysDragMenuItem alloc] initWithTitle:@"UzysSlide Menu" image:[UIImage imageNamed:@"0.png"] action:^(UzysDragMenuItem *item) {
    NSLog(@"Item: %@", item);

}];
item0.tag = 0;
```

####2. make controlview

``` objective-c
UzysDragMenuControlView *controlView = [[[NSBundle mainBundle] loadNibNamed:@"UzysDragMenuControlView" owner:self options:nil] lastObject];
    
[controlView.btnAction addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
```

####3. make UzysDragmenu
``` objective-c
self.uzysDmenu = [[UzysDragMenu alloc] initWithItems:@[item0,item1,item2]
                                         controlMenu:controlView
                                    superViewGesture:YES];
[self.view addSubview:self.uzysDmenu];
```

## Contact

 - [Uzys.net](http://uzys.net)

## License

 - See [LICENSE](https://github.com/uzysjung/UzysDragMenu/blob/master/MIT-LICENSE.txt).
