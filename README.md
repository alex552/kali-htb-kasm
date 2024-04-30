# kali-htb-kasm

> Still Work in progress!



## Configuration for KASM Workspaces:

To enable VPN connections in your container, insert the following configuration into the Docker Run Config Override (JSON) section in the KASM workspace web configuration:

```json
{
    "cap_add": ["NET_ADMIN"],
    "devices": ["/dev/net/tun", "/dev/net/tun"],
    "sysctls": {
        "net.ipv6.conf.all.disable_ipv6": "0"
    }
}
````

## Building the Image:

To build the Docker image, run the following command in your terminal:

> Replace customName:example with your desired image name and tag.
```sh 
docker build -t customName:example -f Dockerfile .
```



