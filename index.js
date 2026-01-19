const port = process.env.PORT || 3000; 

app.listen(port, '0.0.0.0', () => {
    console.log(`服务已启动，监听端口：${port}`);
});
