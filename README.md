# 演示页的永久入口（GitHub Pages）

这个目录是一个**纯静态跳转页**。把它放到 GitHub Pages 上，你就得到一个永远不变的地址：

```
https://hhhlllyyy040503-beep.github.io/icbc-demo/
```

打开它会自动跳到当前的线上演示页。演示页重新发布换了域名，**只需要改 `latest.json` 里的一行**，这个固定地址不变。

目录里只有三个文件，没有任何密钥、没有数据，可以放心公开：

| 文件 | 作用 |
|---|---|
| `index.html` | 跳转页本身（先读 `latest.json`，读不到就用内置的兜底链接） |
| `latest.json` | **当前目标链接**，换链接只改这里 |
| `set-link.sh` | 命令行换链接的小脚本 |

## 一次性设置

1. 仓库已建好：`hhhlllyyy040503-beep/icbc-demo`（Public）。
2. 文件已推送（`main` 分支）。本目录已与远端关联，后续直接 `git push`。
3. Pages 已开启：`main` 分支、`/ (root)` 目录。
4. 固定入口地址（已验证可访问）：

   ```
   https://hhhlllyyy040503-beep.github.io/icbc-demo/
   ```

这个地址**永远不变**，发给评委、写进材料都用它。

## 以后每次重新发布演示页

```bash
cd github-entry
./set-link.sh https://新的分享链接.sg2.agentos-app.run
git add latest.json && git commit -m "chore: 更新演示链接" && git push
```

约 1 分钟后生效。固定入口地址不用重新分发。

> 注意：`set-link.sh` 只改 `latest.json`，不会碰 `index.html`。
> 如果不想用脚本，直接手改 `latest.json` 里的 `url` 字段效果一样。

## 为什么不用 GitHub Pages 直接托管演示页

GitHub Pages 只能托管静态文件（HTML/CSS/JS），**没有 Python 运行时**。
这个演示是 Streamlit 应用，必须有一个持续运行的 Python 服务，所以只能放在能跑 Python 的平台上，
Pages 这里只承担「固定入口 + 跳转」的角色。

## 如果想要连「改一行」都省掉

那就把应用本身迁到 **Streamlit Community Cloud**（官方免费托管）：

- 地址形如 `https://<应用名>.streamlit.app`，**push 代码后自动重新部署，链接始终不变**；
- 代价：仓库必须公开、密钥要填在它的 Secrets 面板（本项目的 `app.py` 已支持 `st.secrets` 兜底）、
  免费版闲置后会休眠，首次访问需等待唤醒。

对比赛演示来说，两者可以并存：Pages 做对外固定入口，应用放哪都行。
