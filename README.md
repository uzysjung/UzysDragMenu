UzysDragMenu
================

An alternative to the UIImagePickerController editor with extended features.
![Screenshot](https://github.com/uzysjung/UzysDragMenu/raw/master/UzysDragMenu.png)

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
- make menu Item

``` objective-c
UzysDragMenuItem *item0 = [[UzysDragMenuItem alloc] initWithTitle:@"UzysSlide Menu" image:[UIImage imageNamed:@"0.png"] action:^(UzysDragMenuItem *item) {
    NSLog(@"Item: %@", item);

}];
item0.tag = 0;
```

- make controlview
``` objective-c
UzysDragMenuControlView *controlView = [[[NSBundle mainBundle] loadNibNamed:@"UzysDragMenuControlView" owner:self options:nil] lastObject];
    
[controlView.btnAction addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
```

- make UzysDragmenu
``` objective-c
self.uzysDmenu = [[UzysDragMenu alloc] initWithItems:@[item0,item1,item2]
                                         controlMenu:controlView
                                    superViewGesture:YES];
[self.view addSubview:self.uzysDmenu];
```
