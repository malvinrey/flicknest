import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool _isSearchActive = false; // State to track if search is active

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // Background color for the header
      padding: EdgeInsets.symmetric(vertical: 8), // Vertical padding only
      child: Row(
        children: [
          // Left Section: Menu and Logo
          Expanded(
            flex: 3, // Allocate space for menu and logo
            child: Padding(
              padding: const EdgeInsets.only(left: 16), // Equal padding to the left
              child: Row(
                children: [
                  // Menu Icon
                  Icon(Icons.menu, color: Colors.white, size: 20),
                  SizedBox(width: 15), // Space between menu and logo
                  // Logo Image with Rounded Corners
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8), // Rounded edges for the image
                    child: Image.asset(
                      '../assets/images/logo.png', // Path to the logo file
                      height: 40,
                      width: 40, // Adjust width to keep image square
                      fit: BoxFit.cover, // Ensure the logo fills the rounded container
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Center Section: Search Icon or Input Field
          _isSearchActive
              ? Expanded(
                  flex: 4, // Allocate more space for search bar
                  child: Container(
                    height: 40, // Consistent height for the search bar
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8), // Rounded corners for the search bar
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12), // Horizontal padding
                            child: TextField(
                              textAlignVertical: TextAlignVertical.center, // Align text vertically
                              decoration: InputDecoration(
                                hintText: 'Enter movie title...',
                                hintStyle: TextStyle(color: Colors.black54, fontSize: 12),
                                border: InputBorder.none, // Remove default border
                                isDense: true, // Reduces padding inside TextField
                              ),
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12), // Padding for the X icon
                          child: IconButton(
                            icon: Icon(Icons.close, size: 20, color: Colors.black54),
                            onPressed: () {
                              setState(() {
                                _isSearchActive = false; // Close search bar
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Expanded(
                  flex: 2, // Allocate smaller space when search is inactive
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.search, color: Colors.white, size: 20),
                      onPressed: () {
                        setState(() {
                          _isSearchActive = true; // Open search bar
                        });
                      },
                    ),
                  ),
                ),

          // Right Section: Sign In and Add Icon
          Expanded(
            flex: 3, // Allocate space for Sign In and Add Icon
            child: Padding(
              padding: const EdgeInsets.only(right: 16), // Equal padding to the right
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.add_circle, color: Colors.yellow[700], size: 24),
                    onPressed: () {
                      _showAddOptionsDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to show the dialog with Add options
  void _showAddOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center( // Ensures the dialog is centered
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16), // Add horizontal padding
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black, // Dialog background color
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.all(16), // Padding for the entire dialog
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Minimize height to content
                  children: [
                    Text(
                      "Add Options",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.yellow[700], // Yellow color for title
                      ),
                    ),
                    SizedBox(height: 8), // Space between title and content
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.movie, color: Colors.blueAccent, size: 20),
                      title: Text(
                        "Add Movie",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Divider(color: Colors.grey, thickness: 0.5),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.rate_review, color: Colors.greenAccent, size: 20),
                      title: Text(
                        "Review Movie",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(height: 16), // Add space between content and close button
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.redAccent),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
