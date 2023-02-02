<html xmlns="http://www.w3.org/1999/xhtml">
  <title>Parser railroad</title>
  <style>html {
  height: 100%;
}

body {
  height: 100%;
  margin:0;
  display: flex;
}

.Content {
  flex-grow: 1;
}

.Sidebar {
  width: 200px;
  flex-shrink: 0;
  overflow: scroll;
}</style>
  <body>
    <nav class="Sidebar" style="background:rgb(235, 236, 236)"><h2 id="title">Productions</h2>
      <ul id="names">
      </ul>
    </nav>
    <iframe  id="parser" class="Content" name="parser" src="xx.xhtml">??</iframe>
    <script>window.addEventListener("hashchange", function () {
       var hash=window.location.hash.substring(2);
       alert(hash);
        document.getElementById('parser').getElementById(hash).scrollIntoView();
    });</script>
  </body>
</html>