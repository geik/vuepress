# VuePress

A docker container that builds a Vuepress site.
Starting point = a `documentation directory` - containing markdown files and subdirectories that also contain markdown files.

## Local development

Build it.

```cmd
docker build --tag vuepress .
```

Run it. The documentation directory is mapped as volume to a (non already existing) directory within the container itself.

```cmd
docker run -it -p 8080:8080 -v c:\dev\vuepress\docs:/docs vuepress
```

Inside the container, build the vuepress site using the powershell script. In this script the vuepress sidebar is generated automatically from the documentation directory's content. The `vuepress build` command is part of the build script. 

```sh
pwsh /build.ps1 /docs
```

Watch your generated website files in /docs/.vuepress/dist.

Run the generated website on port 8080. Then open your website in a browser at <http://localhost:8080>.

```sh
vuepress dev /docs
```

## Vuepress notes

- A sidebar CANNOT specify a `README.md` explicitly

## Many thanks to ...

- <https://techformist.com/automatic-dynamic-sidebar-vuepress/>
- <https://blog.howar31.com/vuepress-blog-tutorial/#enable-navbar-and-sidebar>
- <https://adamtheautomator.com/powershell-arraylist/>
- <https://www.darkoperator.com/blog/2012/4/18/introduction-to-microsoft-powershell-ndash-variables.html>
