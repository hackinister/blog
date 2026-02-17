import os
import re
import shutil

# Paths
posts_dir = "/home/ctimm/Development/Blog/content/posts/"
attachment_dir = "/home/ctimm/Documents/Z_Dateien/"
static_images_dir = "/home/ctimm/Development/Blog/static/images/"

for filename in os.listdir(posts_dir):
    if filename.endswith(".md"):
        filepath = os.path.join(posts_dir, filename)

        with open(filepath, "r") as file:
            content = file.read()

        images = re.findall(r"\[\[([^]]*\.(?:png|webp))\]\]", content)

        for image in images:
            markdown_image = (
                f"![Image Description](/images/{image.replace(' ', '%20')})"
            )
            content = content.replace(f"[[{image}]]", markdown_image)

            image_source = os.path.join(attachment_dir, image)
            if os.path.exists(image_source):
                shutil.copy(image_source, static_images_dir)

        with open(filepath, "w") as file:
            file.write(content)

print("Markdown files processed and images copied successfully.")
