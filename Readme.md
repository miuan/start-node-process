# Start Node Process (SNP)

Purpose of this project is create pretty light manager like `pm2`.

It is bunch of `bash` scripts for start (restart, stop) Node.js process (package) in background. 

```
# example of start `npm run prod`
$ snp start prod
```

Also providing easy way, how to update node projects from git. 

```
# example of update process runned by `npm run prod`
$ snp update prod
```

Update have these steps:
1. stop
2. pull source code
3. call `npm ci`
4. restart process again

## 1. Install 

### Localy

```
$ git clone git@github.com:miuan/start-node-process.git
$ mkdir ~/bin
$ ln -s ~/start-node-process/src/snp.sh ~/bin/snp
$ chmod ug+x ~/bin/snp
$ . ~/.profile 
```

if `. ~/.profile` dosn't work you can try alternatively the `source ~/.bash_profile` maybe more information about this topic you can find on https://stackoverflow.com/questions/4608187/how-to-reload-bash-profile-from-the-command-line

```
$ snp # should show you a help of usage
```

## 2. Usage

### 1. Start

start `npm run xxx` command in background

```
$ cd any-node-project/
$ snp start               # will run `npm start`
```

specify npm run command:

```
$ snp start dev          # will run `npm run dev`
$ snp start start:prod   # will run `npm run start:prod`
```

### 2. Restart

restart `npm run xxx` command what was runned in background

```
$ cd any-node-project/
$ snp restart              # will restart `npm start` command
```

specify what npm run command should be restarted:

```
$ snp restart dev          # will stop previus running `dev` instance and start again `npm run dev`
$ snp restart start:prod   # will run stop previus running `start:prod` instance and start again `npm run start:prod`
```

### 3. Update

stop `npm run xxx` command what was runned in background, update git, call `npm install` and start `npm run xxx` command again

```
$ cd any-node-project/
$ snp update              # will update `npm start` command and start again
```

specify what npm run command should be restarted:

```
$ snp update dev          # will update previous running `dev` instance and start again
$ snp update start:prod   # will update previous running `start:prod` instance and start again
```

### 4. Stop

stop `npm run xxx` command what was runned in background

```
$ cd any-node-project/
$ snp stop              # will stop `npm start` command
```

specify what npm run command should be restarted:

```
$ snp stop namespace           # will stop all running instancess with the same namespace 
$ snp stop namespace project   # will stop all running instancess with the same namespace and project
$ snp stop namespace project script   # will stop previus running `start:prod` instance
```

### 4. State

show all runing `npm run xxx` commands

```
cd any-node-project/
snp state              # will show only running `npm start` command
```

specify what npm run command should be restarted:

```
snp state namespace           # will show all running instances with the same namespace 
snp state namespace project   # will show all running instances with the same namespace and project
snp state namespace project script   # will show only running `npm run script` instance
```


### 5. Tail

tali -f log file of runing `npm run xxx` command

```
cd any-node-project/
snp tail              # will show log of running `npm start` command
```

specify what npm run command should be restarted:

```
snp update dev          # show log file of running `dev` instance
snp update start:prod   # show log file of running `start:prod` instance 
```

## Have Fun :)