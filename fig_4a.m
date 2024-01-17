clear all;
clc;
color={[5,80,91]./256,[255,80,80]./256,[48,151,164]./256,[255,170,50]./256,[0.6902,0.4784,0.6314],[200,100,50]./256};
marker={"o","*","pentagram","diamond","square","^"};
l_sum=0;
gamma=0.5;
L=100;
l_length=L;
U=150;
W=50;
N=300;
R=1e5;
t_ens=5e-2;
t_des=5e-2;
t_s=t_ens+t_des;
n=1:l_length;

y=[];
for i=1:l_length
    y(i)=N*W/R;
end
plot(n,y,'LineWidth',3,'HandleVisibility','on')
hold on;

y1=[];
for i=1:l_length-27
    y1(i)=(i+27)*U/R+t_ens+t_des;
end
plot(28:l_length,y1,'-','LineWidth',3,'Color',[62,43,109]./256,'HandleVisibility','off')
hold on;

y1=[];
for i=1:28
    y1(i)=i*U/R+t_ens+t_des;
end
plot(1:28,y1,'--','LineWidth',2,'Color',[62,43,109]./256,'HandleVisibility','on')
% hold on;

for l=1:l_length
    l_sum=l_sum+l.^(-gamma);
end

z=0.2;
upp=2.1;
for k=1:z:upp
    den=[];
    den(1)=1*U/R+(1-k*1/l_sum)*(N+1)*W/R+t_ens+t_des;
    m_sum=[];
    m_sum(1)=1.^(-gamma);
    m_sum1(1)=m_sum(1);
    if 1-k*m_sum1(1)/l_sum<0
        m_sum1(1)=l_sum/k;
    end
    den(1)=1*U/R+(1-k*m_sum1(1)/l_sum)*(N+1)*W/R+t_ens+t_des;
    for m=2:l_length
        m_sum(m)=m_sum(m-1)+m.^(-gamma);
        m_sum1(m)=m_sum(m);
        if 1-k*m_sum1(m)/l_sum<0
            m_sum1(m)=l_sum/k;
        end
        den(m)=m*U/R+(1-k*m_sum1(m)/l_sum)*(N+1)*W/R+t_ens+t_des;
        r1(1)=(1-k*m_sum(1)/l_sum);
        r1(m)=(1-k*m_sum(m)/l_sum);
    end
    kkk=round((k-1)/z+1);
    maker_idx=2*kkk:10:l_length;
    plot(n,den,'Marker',marker{kkk},'LineWidth',2,'Color',color{kkk},'MarkerIndices',maker_idx,'MarkerSize',6)
    kkk1=sprintf('%.1f',(kkk-1)*z+1);
    str{kkk}=['{\it{k}}=',num2str(kkk1)];
    str{kkk}=strcat(str{kkk});
    hold on;
end

for k=1:z:upp
    den=[];
    den(1)=1*U/R+(1-k*1/l_sum)*(N+1)*W/R+t_ens+t_des;
    m_sum=[];
    m_sum(1)=1.^(-gamma);
    m_sum1(1)=m_sum(1);
    for m=2:l_length
        m_sum(m)=m_sum(m-1)+m.^(-gamma);
        m_sum1(m)=m_sum(m);
        den(m)=m*U/R+(1-k*m_sum1(m)/l_sum)*(N+1)*W/R+t_ens+t_des;
        r1(1)=(1-k*m_sum(1)/l_sum);
        r1(m)=(1-k*m_sum(m)/l_sum);
    
    end
    kkk=round((k-1)/z+1);
    % plot(n,den,'--','LineWidth',2,'Color',color{kkk},'HandleVisibility','off')
    hold on;
end

y1=[];
for i=1:l_length-27
    y1(i)=(i+27)*U/R+t_ens+t_des;
end
% plot(28:l_length,y1,'-','LineWidth',3,'Color',[62,43,109]./256,'HandleVisibility','off')
hold on;


% y2=[];
% for i=1:l_length
%     y2(i)=(i*U+(1-beta)*(N+1))/R+t_ens+t_des;
% end
% plot(1:l_length,y2,'--','LineWidth',2,'Color','blue','HandleVisibility','off')
% hold on;

axis([1,inf,0,inf])
legend('Conventional Mode','Semantic Mode (Error Free)','Semantic Mode ({\itk}=1.0)','Semantic Mode ({\itk}=1.2)','Semantic Mode ({\itk}=1.4)','Semantic Mode ({\itk}=1.6)','Semantic Mode ({\itk}=1.8)','Semantic Mode ({\itk}=2.0)','location','Southeast','FontName','Times New Roman','FontSize',11,'LineWidth',1.5);

% axis([1,l_length,0,2])
% legend('FontName','Times New Roman','FontSize',14,'LineWidth',1.5);
% legend('$$k=\frac{MU+W+R(t_{en-s}+t_{de-s})}{(N+1)W{\frac{\sum_{i=1}^{M} i^{-\gamma}}{\sum_{i=1}^{L} i^{-\gamma}}}}$$','$${k}=\beta\frac{\sum_{i=1}^{L} i^{-\gamma}}{\sum_{i=1}^{M} i^{-\gamma}}$$','$$k=k_{max}$$','$${k}=\frac{\sum_{i=1}^{L} i^{-\gamma}}{\sum_{i=1}^{M} i^{-\gamma}}$$','Interpreter','latex','FontSize',12,'location','NorthEast');
% axis([1,l_length,1,5.021])
% legend('FontName','Times New Roman','FontSize',14,'LineWidth',1.5);
% legend('Conventional Mode','Semantic Mode (Error-Free)','Semantic Mode','Semantic Mode','location','SouthEast');
% legend('Conventional Mode','Semantic Mode (Error-Free)','Semantic Mode','Interpreter','latex','FontSize',12,'location','SouthEast');
grid on
set(gca,'FontName','Times New Roman','FontSize',14,'LineWidth',1.5);
xlabel('Transmitted Semantic Triplet Quantity {\it M}','FontName','Times New Roman','FontSize',14);
ylabel('Latency {\it t} (s)','FontName','Times New Roman','FontSize',14,'LineWidth',1.5);
set(gca,'XTick',[1,10,20,30,40,50,60,70,80,90,100]);
fig=gcf;
fig.PaperPositionMode='auto';
fig_pos=fig.PaperPosition;
fig.PaperSize=[fig_pos(3) fig_pos(4)];
