import os

should_inject = False

dev_junk = ""
if should_inject:
	dev_junk = """
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/1.3.6/socket.io.min.js"></script>
<script type="text/javascript" charset="utf-8">
	/*var socket = io.connect('http://localhost:1212' + document.domain + ':' + location.port);*/
	var socket = io.connect('http://localhost:1212/socker.io/socker.io');
	socket.on('connect', function()
	{
		console.log('connected');
	});
	socket.on('message', function(data)
	{
		console.log(data);
	});
</script>
"""

if os.path.exists(".dev"):
	os.system("rm -fdr .dev")
os.system("cp -R Output .dev")

folders = ["Output","Output/about","Output/posts","Output/tags"]

html_files = []

for folder in folders:
	files =  os.listdir(folder)
	for f in files:
		if f.endswith(".html"):
			html_files.append(os.path.join(folder,f))

for html_file in html_files:
	f = open(html_file,"r")
	s = f.read()
	f.close()

	s = s.replace("</head>",f"{dev_junk}</head>")

	dest = html_file.split("/")
	dest[0] = ".dev"
	dest = "/".join(dest)

	f = open(dest,"w")
	f.write(s)
	f.close()

