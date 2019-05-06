var s = require('net').Socket();
s.connect(8080);
s.write("The Public IP of the System has changed. I am restarting the emby-server. I'll be up in a Second");
s.end();
