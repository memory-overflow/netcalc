#include<stdio.h>
#include<string.h>
#include<math.h>
#include "../include/mongoose.h"
extern int mg_destory_server();
extern double get(); 
char buffer[100];
void swap(char *a,char *b)
{
	char tmp=*a;
	*a=*b;
	*b=tmp;
}
const char* tranDoubleToString(double x)
{
	int x_int,pos=0;
	int i,j,fg=0;
	double eps =1e-5;
	if(x<0)
	{
		buffer[pos++]='-';
		x=fabs(x);
		fg++;
	}
	x_int =(int)x;
	x+=eps/2;
	x-=x_int;
	if(x_int==0)
		buffer[pos++]='0';
	else
	{
		while(x_int)
		{
			buffer[pos++]=x_int%10+'0';
			x_int/=10;
		}
		for(i=fg,j=pos-1 ; i<j;i++,j--)
			swap(&buffer[i],&buffer[j]);
	}
	if(fabs(x)>eps)
	{
		buffer[pos++]='.';
		while(fabs(x)>eps)
		{
			x*=10;
			eps*=10;
			buffer[pos++]=(int)x+'0';
			x-=(int)x;
		}
	}
	buffer[pos]=0;
	return buffer;
}
static int getnum(struct mg_connection *conn)
{
//	printf("request_method = %s\n",conn->request_method);
//	printf("URI = %s\n",conn->uri);
//	printf("content = %s\n",conn->content);
//	printf("content_len = %d\n",conn->content_len);
//	printf("remote_port = %d\n",conn->remote_port);

	
	double ret = get(conn->content,conn->content_len);
	//printf("file %s ans = %f\n","serve.c",ret);
	
	//mg_send_status(conn,1);
	//mg_send_header(conn,"islands","zxymylove");
	const char * result = tranDoubleToString(ret);
	mg_send_data(conn,result,strlen(result));
	//mg_printf_data(conn,result);
	return 0;
}
int main()
{
	struct mg_server *server;
	server = mg_create_server(NULL);
	mg_set_option(server,"listening_port","8080");
	mg_add_uri_handler(server,"/",getnum);
	
	printf("Starting server on port %s\n",mg_get_option(server,"listening_port"));
	while(1) mg_poll_server(server,500);

	mg_destory_server(&server);
	return 0;
}
