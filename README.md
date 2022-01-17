# Password-Wordlists
[wordlists.sh](wordlists.sh) is a small bash script to generate password wordlists.

## Instructions
[wordlists.sh](wordlists.sh) works in three phases:

1. [SecLists](https://github.com/danielmiessler/SecLists) is cloned in the current working directory.
[SecLists](https://github.com/danielmiessler/SecLists) is a collection of multiple types of lists used during security assessments, collected in one place.

2. Every wordlist in the [Passwords](https://github.com/danielmiessler/SecLists/tree/master/Passwords) directory is checked,
except for [Default-Credentials](https://github.com/danielmiessler/SecLists/tree/master/Passwords/Default-Credentials),
[Malware](https://github.com/danielmiessler/SecLists/tree/master/Passwords/Malware),
[Permutations](https://github.com/danielmiessler/SecLists/tree/master/Passwords/Permutations),
and files containing "withcount" in their name.
These directories are not checked as they do not contain proper password wordlist in the right format.
Wordlists are aggregated in 5 different file size: small, medium, medium large, large and very large.
These wordlists are saved in a "Password_Wordlist" directory in the current working directory.
Each file size aggregates every wordlist found smaller than a specified size, as seen in the following table:

| File name   | Small | Medium | Medium Large | Large | Very Large                          |
|-------------|-------|--------|--------------|-------|-------------------------------------|
| Target size | 6 KB  | 10 KB  | 100 KB       | 10 MB | Every file found, whatever its size |

File names and target sizes can easily be customized in the script.

3. Many files contain the same passwords, so only uniq entries are kept.
This way we obtain more exhaustive password wordlists of different sizes.
Small and medium wordlists are especially useful for online attacks, and large wordlists are more complete than [rockyou.txt](https://github.com/danielmiessler/SecLists/blob/master/Passwords/Leaked-Databases/rockyou.txt.tar.gz) for offline attacks.

## Install
```sh
curl -O https://raw.githubusercontent.com/adrienls/Password-Wordlists/main/wordlists.sh
```

## Usage
```bash
# Download SecLists and generate wordlists in the current directory
bash wordlist.sh
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## Author
* [adrlsx](https://github.com/adrlsx)

## License
This project is licensed under the GNU AGPLv3 License - see the [LICENSE.md](LICENSE) file for details.

License chosen thanks to [choosealicense.com](https://choosealicense.com/).
