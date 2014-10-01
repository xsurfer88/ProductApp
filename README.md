ProductApp
==========

use coredata perform retail excercise:

1.	Efficient memory management should be performed
2.	Must support various screen sizes.
3.	Good commenting, and following of design patterns expected.

Assignment.
1.	Ensure you follow a consisting coding style (i.e naming conventions, spacing, etc.) 
2.	Review the following model.

Class = Product
Fields
id
name
description
regular price
sale price
product photo (image)
colors (array)
stores (dictionary)

3.	Create a new app that showcases the following.
a.	Creation of the model.
b.	Create mock data for the models using json. Show case at least 3 mock products.
c.	Use of Persistent Storage to store the model. Implement the following.
i.	INSERT
ii.	SELECT
iii.	DELETE
iv.	UPDATE
d.	Provide the main view controller will have a button that is labeled “Show Product” and “Create Product”.
i.	Start with “Create Product” from the json data. You can either create buttons that say “Create Product 1”, “Create Product 2”, etc, OR show a better way to dynamically create these products.  This should effective INSERT a row into the products table.
ii.	Next, “Show Product” should provide the user with a list of products in the database and selecting a product brings you to a product page.
e.	Create a new view controller that shows the product. You have freedom of UX here on how you want the information to be displayed.
f.	Provide buttons to “Update” and “Delete”. 
g.	Touching the image thumbnail will show a full size image.
h.	Please deliver view controllers and cells as h, m, and nib files. The only exception is the first view controller launched from the storyboard.
i.	Please use as much as possible, UI objects from the native framework. 
j.	Document any 3rd party libraries used and why.
k.	Unit tests is optional but a big plus 

