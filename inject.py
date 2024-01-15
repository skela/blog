import os

should_inject_dev_junk = False

dev_junk = ""
if should_inject_dev_junk:
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

script_junk = """
<script>
	const cmd = document.querySelector("#header_nav_terminal_cmd");

	const posts = document.querySelector("#header_nav_posts");
	posts.addEventListener("mouseenter", (el) => {
		cmd.innerText = "cd posts";
	});
	posts.addEventListener("mouseleave", (el) => {
		cmd.innerText = "ls .";
	});

	const about = document.querySelector("#header_nav_about");
	about.addEventListener("mouseenter", (el) => {
		cmd.innerText = "cd about";
	});
	about.addEventListener("mouseleave", (el) => {
		cmd.innerText = "ls .";
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

	s = s.replace("</body>",f"{script_junk}</body>")
	f = open(html_file,"w")
	f.write(s)
	f.close()

	s = s.replace("</head>",f"{dev_junk}</head>")

	dest = html_file.split("/")
	dest[0] = ".dev"
	dest = "/".join(dest)

	f = open(dest,"w")
	f.write(s)
	f.close()

