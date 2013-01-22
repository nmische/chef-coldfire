Description
===========

Installs ColdFire debugging template. 

Recipes
=======
  
  * `coldfire` - Installs ColdFire debugging template and configures ColdFusion to use it.


Attributes
=============

  * `node['coldfire']['download_url']` - The URL for the ColdFire installation bits. Default is: "http://coldfire.riaforge.org/downloads/coldfire_v1.11.208.251.zip"
  * `node['coldfire']['ip_list']` - A list of IP addresses for which to enable debugging.