import json

"""
This script filters out all of the lines from the compile_commands.json file that belong
to an external folder.
"""

f = open("compile_commands.json")
data = json.load(f)
f.close()

res = []
for i in data:
  path = ""
  if "directory" in i:
    path = i["directory"]
  elif "file" in i:
    path = i["file"]
  else:
    raise "No directory or file"
  is_ext = "/ext/" in path

  in_ghoul = "/ext/ghoul/" in path
  in_ghoul_ext = "/ext/ghoul/ext" in path
  in_ghoul_not_ext = in_ghoul & (not in_ghoul_ext)

  in_sgct = "/ext/sgct/" in path
  in_sgct_ext = "/ext/sgct/ext" in path
  in_sgct_not_ext = in_sgct & (not in_sgct_ext)

  in_launcher = "/ext/launcher" in path

  in_cef_wrapper = "libcef_dll_wrapper" in path

  is_moc = "/moc_" in path

  is_extended_ext = is_ext | in_cef_wrapper
  in_allowed_ext = in_ghoul_not_ext | in_sgct_not_ext | in_launcher

  should_reject = (is_extended_ext & (not in_allowed_ext)) | is_moc

  if (not should_reject):
    res.append(i)

f = open("compile_commands.json", "w")
f.write(json.dumps(res, indent=2))
