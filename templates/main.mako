<!DOCTYPE html>
<html lang="en-US">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${config.title}</title>
  <link rel="stylesheet" href="style.css">
  <style>
    html {
        background:
          linear-gradient(
            rgba(0, 0, 0, ${config.background_opacity}),
            rgba(0, 0, 0, ${config.background_opacity})
          ),
          url('${config.background}'),
          rgba(0,0,0);
    }
  </style>
  <script src="https://kit.fontawesome.com/6bee25835f.js" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fork-awesome@1.2.0/css/fork-awesome.min.css" integrity="sha256-XoaMnoYC5TH6/+ihMEnospgm0J1PM/nioxbOUdnM8HY=" crossorigin="anonymous">
  <link rel="icon" href="${config.avatar}" type="image/x-icon" />
</head>

<body>
  <a class="profilePicture">
    <img src="${config.avatar}" alt="Profile Picture">
  </a>
 
  <div class="userName">
    ${config.name}
  </div>

  <div class="description">
    ${config.description}
  </div>
  % for section in links:
    <div class="sectionTitle">
      ${section.title}
    </div>
    <div class="links">
      % for link in section.links:
        % if 'href' in link and 'copy' in link:
        
          <a class="link" href="${link.href}" target="_blank">
            <i class="${link.icon}"></i> ${link.text}
            <div class="tooltip">
              <span class="" href="#" onclick="copytext('${link.copy}','${link._id}')" onmouseout="outFunc('${link._id}')">
                <span class="tooltiptext" id="${link._id}">Copy to clipboard</span>
                <i class="fa-solid fa-copy"></i>
              </span>
            </div>
          </a>
        % elif 'href' in link:
        <a class="link" href="${link.href}" target="_blank">
          <i class="${link.icon}"></i> ${link.text}
        </a>
        % elif 'copy' in link:
        <div class="tooltip block">
        <a class="link" href="#" onclick="copytext('${link.copy}','${link._id}')" onmouseout="outFunc('${link._id}')">
          <span class="tooltiptext" id="${link._id}">Copy to clipboard</span>
          <i class="${link.icon}"></i> ${link.text}
        </a>
        </div>
        % endif
      % endfor
    </div>
  % endfor

  <footer>
    <div class="footer">
      Last updated: ${metadata.last_updated}
    </div>
  </footer>

</body>
<script>
  function copytext(val, linkid) {
    event.preventDefault();
    console.log(val);
    navigator.clipboard.writeText(val);
    var tooltip = document.getElementById(linkid);
    tooltip.innerHTML = "Copied: " + val;
  }

  function outFunc(linkid) {
    var tooltip = document.getElementById(linkid);
    tooltip.innerHTML = "Copy to clipboard";
  }
</script>
</html>
