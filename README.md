# VuePress

A docker container that builds a Vuepress site.
Starting point = a docsdir = your `documentation directory` - containing markdown files and subdirectories that also contain markdown files.

## Build the container

Build it.

```cmd
docker build --tag vuepress .
```

## Prepare your documentation

Put a `.vuepress` directory into your docsdir. Containing a vuepres `config.js` file that:
- for its sidebar - points to a `sidebar.json` file
- has a `base` parameter that is either `/` or the base url of your deployed & hosted website

## Use the container

The documentation directory is mapped as volume to a (non already existing) directory within the container itself.

```cmd
docker run -it -p 8080:8080 -v c:\dev\vuepress\docs:/docs vuepress
```

Build the vuepress site using the powershell script. In this script the vuepress sidebar is generated automatically from the documentation directory's content, to the file `sidebar.json`.

```sh
pwsh /build-sidebar.json.ps1 /docs
```

Preview the generated website on port 8080 via `vuepress dev`. Then open your website in a browser at <http://localhost:8080>.

```sh
vuepress dev /docs
```

Generate the website for real to the `dist` directory. 

```sh
vuepress build /docs
```

Watch your generated website files in /docs/.vuepress/dist.



## Vuepress notes

- A sidebar CANNOT specify a `README.md` explicitly

## Many thanks to ...

- <https://techformist.com/automatic-dynamic-sidebar-vuepress/>
- <https://blog.howar31.com/vuepress-blog-tutorial/#enable-navbar-and-sidebar>
- <https://adamtheautomator.com/powershell-arraylist/>
- <https://www.darkoperator.com/blog/2012/4/18/introduction-to-microsoft-powershell-ndash-variables.html>
