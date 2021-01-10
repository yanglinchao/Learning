library(evir)
data(danish)   #����evir���е�danish����
help(danish)

#̽�������ݷ���
summary(danish)
hist(danish, breaks = 200, xlim = c(0, 20))

#�����β����Ϊ
emplot(danish)   #x��ʹ�ö����߶�
emplot(danish, alog = "xy")   #xy�ᶼʹ�ö����߶�
qplot(danish, trim = 100)   #����QQͼ����ʧ������100����β

#��ֵ�ľ���
meplot(danish, omit = 4)   #�����������ӵ���ֵ������ƽ������

#��β�����GPD����
gpdfit <- gpd(danish, threshold = 10)   #���һ��GPD�ֲ�
gpdfit$converged   #converged�ɷֵ���ֵ˵��ʹ�ü�����Ȼ����ʱ�����������ֵ
gpdfit$par.ests
gpdfit$par.ses


#ʹ����ϵ�GPDģ�͹��Ʒ�λ��
tp <- tailplot(gpdfit)   #ֱ�Ӵ���һ��ԭʼ�ĵ��������ʧ�ֲ���β��ͼ��
gpd.q(tp, pp = 0.999, ci.p = 0.95)
quantile(danish, probs = 0.999, type = 1)

#ʹ����ϵ�GPDģ�ͼ���Ԥ����ʧ
tp <- tailplot(gpdfit)
gpd.q(tp, pp = 0.99)
gpd.sfall(tp, 0.99)