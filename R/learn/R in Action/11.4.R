ftable(Titanic)
library(vcd)
mosaic(Titanic, shade = TRUE, legeng = TRUE)
mosaic(~ Class + Sex + Age + Survived, data = Titanic, shade = TRUE, legeng = TRUE)
###���д��붼������ͼ1�����Ǳ���ʽ�汾�Ĵ�����Ƕ�ͼ���б�����ѡ��Ͱڷ�ӵ�и���Ŀ���Ȩ