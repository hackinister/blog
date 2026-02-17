import os
import re
import shutil
import subprocess

# Paths
posts_dir = "/home/ctimm/Development/Blog/content/posts/"
attachment_dir = "/home/ctimm/Documents/Z_Dateien/"
static_images_dir = "/home/ctimm/Development/Blog/assets/img/"

for filename in os.listdir(posts_dir):
    if filename.endswith(".md"):
        filepath = os.path.join(posts_dir, filename)

        with open(filepath, "r") as file:
            content = file.read()

        images = re.findall(r"\[\[([^]]*\.(?:png|webp))\]\]", content)

        for image in images:
            new_filename = image.replace(" ", "-")
            markdown_image = f"![Image Description](/images/{new_filename})"
            content = content.replace(f"[[{image}]]", markdown_image)

            image_source = os.path.join(attachment_dir, image)
            if os.path.exists(image_source):
                shutil.copy(image_source, os.path.join(static_images_dir, new_filename))

        with open(filepath, "w") as file:
            file.write(content)

print("Markdown files processed and images copied successfully.")

# Cleanup unused images
print("Cleaning up unused images...")
search_dirs = [
    "/home/ctimm/Development/Blog/content",
    "/home/ctimm/Development/Blog/layouts",
    "/home/ctimm/Development/Blog/themes",
    "/home/ctimm/Development/Blog/config",
    "/home/ctimm/Development/Blog/archetypes",
]
existing_search_dirs = [d for d in search_dirs if os.path.exists(d)]

if os.path.exists(static_images_dir):
    for filename in os.listdir(static_images_dir):
        if filename.lower().endswith(
            (".png", ".webp", ".jpg", ".jpeg", ".gif", ".svg")
        ):
            filepath = os.path.join(static_images_dir, filename)
            result = subprocess.run(
                ["grep", "-r", "-q", "-F", filename] + existing_search_dirs,
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
            )
            if result.returncode == 1:
                print(f"Deleting unused image: {filename}")
                os.remove(filepath)
            elif result.returncode > 1:
                print(
                    f"Error checking usage for {filename}. grep returned {result.returncode}"
                )

print("Unused images cleaned up successfully.")
