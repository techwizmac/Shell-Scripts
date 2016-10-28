CMS Version Extraction and Listing
-----------------------------------

This is a very crude first attempt at extracting CMS version information from a list of websites.

Often times and for tracking purposes, it is useful to keep track of how website owners keep up with CMS versions in order to stay secure and up to date.
Static Web Scanners do not provide an easy mechanism to gather this information and compile it together for easy viewing. On the other hand there are a number of fingerprinting tools out there that extract HTTP header information which can be visualized within a browser in the form of plugins and extensions depending on the browser flavour. I use a header information extraction tool called Whatweb to routinely extract header information manually. This tool can provide brief and verbose results. What I try to do with this simple script is to extract in CMS versions in bulk and aggregate the information for quicker and practical viewing.
Further improvements coming soon.

Please note that this script is an early state.

Requirements
=============
You need to have the Whatweb utility installed on the system prior to using this script.

Whatweb: https://www.morningstarsecurity.com/research/whatweb

Credits: Written by urbanadventurer aka Andrew Horton and Brendan Coles

License: GPLv2

You also need precreated a list/s of websites that you know are CMS based and you have an interest in tracking.

Notes
=====
24/10/2016: Created a new repo to host the preliminary instance of this script.


