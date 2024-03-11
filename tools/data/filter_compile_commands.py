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
  is_ext = "/ext/" in i["directory"]

  in_ghoul = "/ext/ghoul/" in i["directory"]
  in_ghoul_ext = "/ext/ghoul/ext" in i["directory"]
  in_ghoul_not_ext = in_ghoul & (not in_ghoul_ext)

  in_sgct = "/ext/sgct/" in i["directory"]
  in_sgct_ext = "/ext/sgct/ext" in i["directory"]
  in_sgct_not_ext = in_sgct & (not in_sgct_ext)

  in_launcher = "/ext/launcher" in i["directory"]

  in_allowed_ext = in_ghoul_not_ext | in_sgct_not_ext | in_launcher

  should_reject = is_ext & (not in_allowed_ext)

  if (not should_reject):
    res.append(i)

f = open("compile_commands.json", "w")
f.write(json.dumps(res))
