#### 代码解释

- ulaw.m ：执行μ律

- inv_ulaw.m: 执行反向μ律

- u_pcm.m: 对输入的波进行均匀量化

  ```matlab
  function [a_quan]=u_pcm(a,n)
  a_max = max(abs(a)); % 找到采样点的最大值
  a_quan = a ./ a_max; % 将采样点映射到(-1, 1)
  for i = -1 : 2 / n : 1 % 将(-1, 1)分成n段
      a_quan_seg = a_quan(a_quan >= i & a_quan < (i + 2 / n)); % 获取在(i, i + 2 / n)范围内的采样点 - 其中2/n就是一段的长度
      a_quan(a_quan >= i & a_quan < (i + 2 / n)) = (max(a_quan_seg) + min(a_quan_seg)) / 2; % 取中点采样将这些采样点设为（最大值 + 最小值） / 2
  end
  end
  ```

- ula_pcm.m: 对输入的波进行非均匀量化，根据μ律

  ```matlab
  function [a_quan]=ula_pcm(a,n,u)
  a_max = max(abs(a)); % 找到采样点的最大值
  a_quan = a ./ a_max; % 将采样点映射到(-1, 1)
  for i = -1 : 2 / n : 1 % 将(-1, 1)分成n段
      %非均匀量化需要将信号非线性放大,因此要返回映射值应该对其进行μ律的逆向运算
      a_quan_seg = a_quan(a_quan >= inv_ulaw(i, u) & a_quan < inv_ulaw((i + 2 / n),u)); % 获取在(i, i + 2 / n)范围内的采样点
      a_quan(a_quan >= inv_ulaw(i, u) & a_quan < inv_ulaw((i + 2 / n),u)) = (max(a_quan_seg) + min(a_quan_seg)) / 2; % 将这些采样点设为（最大值 + 最小值） / 2
  end
  end
  ```

  

#### 非均匀量化的优点

当输入量化器的信号具有非均匀分布的概率密度时，非均匀量化器的输出端可以较高的平均信号量化噪声功率比

非均匀量化时，量化噪声功率的均方根值基本上与信号抽样值成比例。因此，量化噪声对大、小信号的影响大致相同，即改善了小信号时的量化信噪比。