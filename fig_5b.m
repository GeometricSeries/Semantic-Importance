clear all;
clc;
color={[5,80,91]./256,[255,80,80]./256,[48,151,164]./256,[255,170,50]./256,[206,190,190]./256,[200,100,50]./256};
marker={"o","*","pentagram","diamond","square","^"};
l_sum=0;
gamma=0.5;
k=1.2;
U=150;
W=50;
N=300;
R=1e5;
t_ens=5e-3;
t_des=5e-3;
t_s=t_ens+t_des;
M_c=0;
M_optimal=[];
t=[];
zp=500;


for kk=1:zp
    i_sum=0;
    mc_sum=0;
    l_sum=0;
    L=kk;
    l_length=L;
    for l=1:l_length
    l_sum=l_sum+l.^(-gamma);
    end
    for m=1:L
        i_sum=i_sum+m.^(-gamma);
        if k*i_sum/l_sum>=1
            M_c=m;
            break;
        end
    end
    if k>=l_sum
        M_optimal(kk)=1;
        t(kk)=M_optimal(kk)*U/R+t_ens+t_des;
        
    else
        if (k*(N+1)*W/(U*l_sum))^(1/gamma)<=1
            M_optimal(kk)=1;
            mopt_sum=0;
            for j=1:M_optimal(kk)
                mopt_sum=mopt_sum+j^(-gamma);
            end
            t(kk)=M_optimal(kk)*U/R+(1-k*mopt_sum/l_sum)*(N+1)*W/R+t_ens+t_des;
        elseif ((k*(N+1)*W/(U*l_sum))^gamma>1)&&((k*(N+1)*W/(U*l_sum))^(1/gamma)<=M_c-1)
            mc_sum=0;
            for l=1:(M_c-1)
            mc_sum=mc_sum+l^(-gamma);
            end
            M_optimal(kk)=floor((k*(N+1)*W/(U*l_sum))^(1/gamma));
            mopt_sum=0;
            for j=1:M_optimal(kk)
                mopt_sum=mopt_sum+j^(-gamma);
            end
            t(kk)=M_optimal(kk)*U/R+(1-k*mopt_sum/l_sum)*(N+1)*W/R+t_ens+t_des;
        else
            mc_sum=0;
            for l=1:(M_c-1)
                mc_sum=mc_sum+l^(-gamma);
            end
            if k*mc_sum/l_sum>(1-U/W/(N+1))
                M_optimal(kk)=M_c-1;
                mopt_sum=0;
                for j=1:M_optimal(kk)
                    mopt_sum=mopt_sum+j^(-gamma);
                end
                t(kk)=M_optimal(kk)*U/R+(1-k*mopt_sum/l_sum)*(N+1)*W/R+t_ens+t_des;
            else
                M_optimal(kk)=M_c;
                t(kk)=M_optimal(kk)*U/R+t_ens+t_des;
            end
        end
    end
end
kk=1:zp;
L=kk;
maker_idx=1:zp/20:zp;
colororder([5/256,80/256,91/256;255/256,80/256,80/256])
yyaxis left
% plot(k,M_optimal,'-','LineWidth',2,'HandleVisibility','on')

plot(L,M_optimal,'-','LineWidth',2.5,'HandleVisibility','on')
ylabel(['Optimal Transmitted', newline 'Semantic Triplet Quantity {\it M^*}'],'FontName','Times New Roman','FontSize',14,'LineWidth',1.5);
axis([1,inf,1,70])
set(gca,'XTick',[1,50,100,150,200,250,300,350,400,450,500]);
set(gca,'YTick',[1,10,20,30,40,50,60,70]);
yyaxis right
% plot(k,t,'-','LineWidth',2,'Color',[255,80,80]./256,'HandleVisibility','on','Marker','*','MarkerIndices',maker_idx,'MarkerSize',6)
plot(L,t,'-','LineWidth',2.5,'HandleVisibility','on','Marker','*','MarkerIndices',maker_idx,'MarkerSize',6)
ylabel('Minimum Latency of Semantic Mode {\it t_{sem}^*} (s)','FontName','Times New Roman','FontSize',14,'LineWidth',1.5);

xlabel('Transformed Semantic Triplet Quantity (Without Filtering) {\itL}','FontName','Times New Roman','FontSize',16);
set(gca,'FontName','Times New Roman','FontSize',14,'LineWidth',1.5);
% set(gca,'XTickLabel',{'1','50','100','150','200'}) ;
set(gca,'YTick',[0,0.025,0.05,0.075,0.1,0.125,0.15,0.175]);
legend(['Optimal Transmitted Semantic', newline 'Triplet Quantity {\it M^*}'], ['Minimum Latency of Semantic', newline, 'Mode {\it t_{sem}^*}'],'location','East','FontName','Times New Roman','FontSize',12,'LineWidth',1.5);
axis([-inf,inf,0,0.175001])
grid on


fig=gcf;
fig.PaperPositionMode='auto';
fig_pos=fig.PaperPosition;
fig.PaperSize=[fig_pos(3) fig_pos(4)];
