import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class agree extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return agree_();
  }
}

class agree_ extends State<agree>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     backgroundColor: Colors.white,
     appBar: AppBar(
       centerTitle: true,
       elevation: 0,
       iconTheme: IconThemeData(
         size: 25.0,
         color: Colors.black, //修改颜色
       ),
       backgroundColor: Colors.white,
       title: Text("用户协议",style: TextStyle(color:Colors.black,),),
     ),
     body: ListView(
       children: <Widget>[
         Container(
           alignment: Alignment.center,
           child: Html(
             data: '<div data-v-9b165fc4="" class="pric_con"><p>重要提示：</p><p>盈满资管企业管理有限公司推出的盈满资管配资平台（以下简称“盈满资管”）依据本协议的规定，为盈满资管的会员（以下简称“会员”）提供服务。本协议在会员和盈满资管间具有法律约束力。盈满资管在此特别提醒您在注册为盈满资管的会员之前，认真阅读、充分理解本协议各条款，特别是其中所涉及的免除及限制盈满资管责任的条款、对会员权利限制条款等。请您审慎阅读并选择接受或不接受本协议的内容。除非您接受本协议所有条款，否则盈满资管有权拒绝您使用盈满资管的申请。您一经注册为盈满资管的会员、使用盈满资管的相关服务即视为您对本协议全部条款已充分理解并完全接受。</p><p><br></p><p>第一章 盈满资管的服务</p><p>第一条</p><p>本协议所称之平台服务是由盈满资管通过公司自建的盈满资管（向会员提供的服务，具体服务内容包括但不限于：交易信息发布、交易管理、客户服务等，具体详情以盈满资管届时提供的服务内容为准。盈满资管享有对平台服务内容的最终解释权。 盈满资管作为居间服务商，不对双方交易的真实性及双方可能产生的违约行为承担责任。</p><p><br></p><p>第二条</p><p>为了保障您的权益，您在自愿注册使用盈满资管的服务前，必须仔细阅读并充分理解知悉本服务协议所有条款。一经注册为盈满资管的会员，或使用平台服务，即视为您对本服务协议内容的充分理解和接受，且愿意以您个人名义独立承担相应的法律责任。</p><p><br></p><p>第三条</p><p>在本协议履行过程中，盈满资管有权对本服务协议的内容进行修改。一旦本服务协议的内容发生变动，盈满资管将通过盈满资管平台公布最新的服务协议，不再向会员作个别通知。公告期一般为五个工作日，如果会员不同意盈满资管对本服务协议所做的修改，会员有权在公告期内申请停止使用平台服务。公告期届满后，如果会员继续使用平台服务的，视为会员接受盈满资管对本服务协议所做的修改，修改后的协议对双方具有法律约束力。</p><p><br></p><p>第四条</p><p>盈满资管对于会员的通知、任何其他告示，或其他关于会员使用会员账户及服务的通知，会员同意盈满资管有权通过盈满资管平台，在其显著的位置公告。同时，除上述通知方式外，盈满资管仍有权通过电子邮件、手机短信、无线通讯装置等电子方式或信件（包括EMS）传递等方式进行公告，该等通知于发送之日视为已送达收件人。以上通告形式具有相同的法律效力，但因信息传输等原因导致会员未在前述通知发出当日收到该通知的，盈满资管不承担责任。</p><p>第五条</p><p>盈满资管有权暂时停止提供，或者限制、改变平台服务。</p><p><br></p><p>第二章 会员</p><p>第六条</p><p>盈满资管的会员是指，符合中华人民共和国法律规定的、具有完全民事权利和民事行为能力、能够独立承担民事责任的自然人，且按照盈满资管制定的注册流程和要求提供注册审核材料后，经盈满资管审核通过后，有权使用盈满资管提供的平台服务的民事主体。</p><p><br></p><p>第七条 会员承诺以下事项：</p><p>1、为注册为会员，您根据注册流程向盈满资管提供的任何信息均真实、准确、完整和有效；</p><p>2、会员有义务维持并更新会员的资料，确保其为真实、准确、完整和有效性。若会员已提交平台的材料发生任何变动，或发现存在任何错误、虚假、过时或不完整的情况，会员应在知道或者应该知道相关事宜之日起1个工作日内进行变更，并通过盈满资管提交更正后的资料。</p><p>3、如盈满资管依其独立判断，认为会员已提交的资料存在任何的错误、虚假、过时或不完整，盈满资管有权暂停会员服务，并通过电子邮件、手机短信、无线通讯装置等电子方式或信件（包括EMS）传递等方式通知会员。会员应在盈满资管通知的时间内并按照第七条第2项的要求和程序进行更正。否则，盈满资管有权终止其会员资格，并终止提供盈满资管服务的部份或全部功能。在此情况下，盈满资管不承担任何责任，并且会员同意负担因此所产生的直接或间接的任何支出或损失。</p><p>4、如发生第七条第3项的情况导致盈满资管服务无法提供或提供时发生任何错误，会员不得将此作为取消交易或拒绝付款的理由，所有后果应由会员承担。</p><p><br></p><p>第三章 盈满资管的服务内容</p><p>第八条</p><p>盈满资管有权通过盈满资管平台提供信息发布服务，即盈满资管有权通过平台向会员、公众提供各种信息及资料。盈满资管发布的相关信息及资料仅作为会员、公众的参考，盈满资管并不对其真实、准确性、合法性作出任何形式的保证。</p><p>会员应依其独立判断做出投资决策。会员据此进行交易的，产生的风险由会员自行承担，会员无权据此向盈满资管或盈满资管平台提出任何法律主张，要求其承担任何责任。</p><p><br></p><p>第九条 盈满资管有权为会员提供以下交易管理服务：</p><p>1、会员在盈满资管进行注册时将生成会员账户，会员账户将记载会员在盈满资管的活动。上述会员账户是会员登陆盈满资管平台的唯一账户。</p><p>2、会员保证并承诺通过盈满资管平台进行交易的资金来源合法。</p><p>3、会员确认，会员在盈满资管平台上按盈满资管服务流程所确认的交易，将成为盈满资管为会员进行相关交易或操作（包括但不限于支付或收取款项、冻结资金、订立合同等）的不可撤销的指令。会员同意相关指令的执行时间以盈满资管在盈满资管平台系统中进行实际操作的时间为准。会员同意盈满资管有权依据本协议及/或盈满资管相关纠纷处理规则等约定对相关事项进行处理。会员未能及时对交易状态进行修改、确认或未能提交相关申请所引起的任何纠纷或损失由会员自行负责，盈满资管不承担任何责任。</p><p>4、会员了解盈满资管并不是银行或金融机构，按照中国法律规定，盈满资管不提供“即时”金额转账服务，会员同意盈满资管或平台对非因其过错导致的资金到账延迟不承担任何责任。</p><p>5、会员理解并同意，盈满资管向符合条件的会员提供服务。盈满资管对会员在盈满资管平台上进行的投资、借款等交易行为不承担任何责任，盈满资管无法也没有义务保证会员在发出投资意向后，能够投资成功，会员因前述原因导致的损失（包括但不限于利息、手续费等损失）由会员自行承担。</p><p>6、会员通过盈满资管平台进行各项交易或接受交易款项时，因未遵从本协议条款或盈满资管公布的交易规则中的操作指示而造成责任或损失，盈满资管不承担任何责任。若发生上述状况而款项已先行汇入会员账户下，会员同意盈满资管有权经通知会员后从相关会员账户中扣回款项。若此款项若已汇入会员的银行账户，盈满资管有权向其索回，由此产生的追索费用由会员承担。</p><p>7、盈满资管有权基于交易安全等方面的考虑临时设定或调整交易制度，包括但不限于交易限额、交易次数等，除非上述临时措施会导致会员重大损失，否则会员有义务遵守临时措施。</p><p>8、如果盈满资管发现了因系统故障或其他任何原因导致的处理错误，无论有利于盈满资管还是有利于会员，盈满资管都有权纠正该错误。如果该错误导致会员实际收到的款项多于应获得的金额，则无论错误的性质和原因，盈满资管保留纠正不当执行的交易的权利，会员应根据盈满资管向会员发出的有关纠正错误的通知的具体要求返还多收的款项或进行其他操作。会员理解并同意，会员因前述处理错误而多付或少付的款项均不计利息，盈满资管不承担因前述处理错误而导致的任何损失或责任（包括会员可能因前述 错误导致的利息、汇率等损失）。</p><p>第十条 盈满资管有权提供以下客户服务：</p><p>1、银行卡认证：为使用盈满资管或盈满资管委托的第三方机构提供的充值、取现、代扣等服务，会员应按照平台规定的流程提交以会员本人名义登记的有效银行借记卡等信息，经由盈满资管审核通过后，盈满资管会将会员的账户与前述银行账户进行绑定。如会员未按照盈满资管规定提交或提交的信息存在错误、虚假、遗漏或无效的情况，或者盈满资管有合理的理由怀疑会员提交的信息存在上述问题且会员未予以纠正的，盈满资管有权拒绝为会员提供银行卡认证服务，会员因此未能使用充值、取现、代扣等服务而产生的损失自行承担。</p><p><br></p><p>2、充值：会员可以使用盈满资管指定的方式向会员账户充入资金，用于通过盈满资管平台进行交易。</p><p>3、代收/代付：盈满资管按照其平台当时向会员开放的功能提供代收/代付服务，自行或委托第三方机构代为收取其他会员或与盈满资管建立合作关系的第三方账户向会员支付的本息等各类款项，或者，将会员账户里的款项支付给会员指定的其他方。</p><p>4、取现：会员可以通过盈满资管届时开放的取现功能将会员账户中的资金转入通过平台认证的银行卡账户中。</p><p><br></p><p>5、查询：会员可以通过盈满资管届时开放的查询功能对会员通过盈满资管进行的操作记录继续查询，但不包含会员经认证的银行卡收款记录，该记录需向银行请求查证。会员理解并同意，通过盈满资管查询的任何信息仅作为参考，不作为相关操作或交易的证据或依据；如该等信息与盈满资管记录存在任何不一致，应以盈满资管提供的书面记录为准。</p><p><br></p><p>会员了解，上述充值、代收/代付及取现服务涉及盈满资管与银行、第三方支付机构等第三方的合作。会员同意：</p><p>（a）盈满资管不对前述服务的资金到账时间做任何承诺，也不承担与此相关的责任，包括但不限于由此产生的利息、货币贬值等损失，到账时间应以第三方的具体交易制度为准。</p><p>（b）一经会员使用前述服务，即表示会员不可撤销地授权盈满资管进行相关操作，会员不能以任何理由拒绝付款或要求取消交易。</p><p><br></p><p>（c）就前述服务，盈满资管保留向会员收取费用的权利，但会员应按照第三方的规定向第三方支付费用，资费标准具体请见第三方网站的相关信息。会员与第三方之间就费用支付事项产生的争议或纠纷，与盈满资管无关。</p><p>6、基于互联网的安全性，会员承诺使用盈满资管的服务时应确保直接登录盈满资管或使用盈满资管提供的链接登陆盈满资管（网址：00341.com）。因会员未遵守上述承诺而造成的任何损失，盈满资管及平台不承担任何责任。</p><p>7、盈满资管及平台有权在提供盈满资管的服务过程中以各种方式投放各种商业性广告或其他任何类型的商业信息。除非会员以书面形式明确拒绝，会员同意接受盈满资管通过电子邮件或其他方式向会员发送商品促销或其他相关商业信息。</p><p><br></p><p>第十一条 盈满资管有权提供以下合同管理服务：</p><p>1、在平台上采用电子合同完成交易。会员使用会员账户登录盈满资管后，根据盈满资管的相关规则，以会员账户ID在盈满资管通过点击确认或类似方式签署的电子合同即视为会员本人对相关交易内容的真实意思表示同意以会员本人名义签署该份电子合同，该电子合同对签署的各方具有法律效力。会员应妥善保管自己的账户密码等账户信息，会员通过前述方式订立的电子合同前应基于商业判断原则谨慎、仔细地阅读电子合同的内容，一经签署，会员不得以其账户密码等账户信息被盗用、未阅读电子合同内容或其他理由否认已订立的合同的效力，或不按照该等合同内容履行相关义务。</p><p>2、会员根据本协议以及盈满资管的相关规则签署的电子合同内容不得修改。盈满资管向会员提供电子合同的备案、查看、核对服务，如对电子合同真伪或电子合同的内容有任何疑问，会员可通过使用盈满资管提供的相关功能进行查阅、核对。如对此有任何争议，应以盈满资管记录的合同为准。</p><p>3、会员不得私自仿制、伪造在盈满资管平台上签订的电子合同或印章，不得用仿制、伪造的合同或印章从事诈骗等非法用途，否则会员应自行承担全部责任。</p><p><br></p><p>第十二条 免责条款</p><p>1、在任何情况下，会员使用盈满资管的服务过程中因涉及由第三方提供相关服务而产生的责任由该第三方承担，会员应向第三方追偿，盈满资管有义务为会员的追偿行为提供必要的协助。上述责任的范围包括但不限于：</p><p>（a）因银行、第三方支付机构等第三方未按照会员和/或盈满资管指令进行操作引起的任何损失或责任；</p><p>（b）因银行、第三方支付机构等第三方原因导致资金未能及时到账或未能到账引起的任何损失或责任；</p><p>（c）银行、第三方支付机构等第三方对交易限额或次数等方面的限制而引起的任何损失或责任；</p><p>（d）其它因第三方行为或原因导致的任何损失或责任。</p><p>2、因会员自身的原因或过错导致的任何损失或责任，由会员自行负责，盈满资管不承担责任。上述责任的范围包括但不限于：</p><p>（a）会员未按照本协议或盈满资管公布的任何规则进行操作导致的任何损失或责任；</p><p>（b）因会员使用的银行卡的原因导致的损失或责任，包括会员使用未经认证的银行卡或使用非会员本人的银行卡，会员的银行卡被冻结、挂失等导致的任何损失或责任；</p><p><br></p><p>（c）会员向盈满资管发送的指令错误、或信息不明确、或存在歧义、不完整、或不符合平台的指令规则等原因导致的任何损失或责任；</p><p><br></p><p>（d） 其他因会员原因或过错导致的任何损失或责任。</p><p><br></p><p>第四章 风险提示</p><p>第十三条</p><p>会员了解并认可，任何通过盈满资管进行的交易并不能避免以下风险的产生，盈满资管不能也没有义务为如下风险负责：</p><p>1、宏观经济风险：因宏观经济形势变化，可能引起价格等方面的异常波动，会员有可能遭受损失。</p><p>2、政策风险：有关法律、法规及相关政策、规则发生变化，可能引起产品或服务类型的调整或终止、价格的异常波动等方面波动，会员有可能遭受损失。</p><p>3、交易对方的违约风险：因其他交易方无力或无意愿按时足额履约导致会员有遭受的损失。</p><p>4、利率风险：市场利率变化可能对购买或持有产品的实际收益产生影响。</p><p>5、其他不可抗力因素导致的风险。</p><p>6、因会员自身原因或过错导致的任何损失，该原因或过错包括但不限于：决策失误、操作不当、遗忘或泄露密码、密码被窃取、会员使用的计算机系统被第三方侵入、会员委托他人代理交易时他人恶意或不当操作而造成的损失。</p><p><br></p><p>除非平台交易规则中明确说明，盈满资管不对任何会员进行的任何交易提供任何担保或保证。</p><p>第十五条</p><p>盈满资管或盈满资管平台仅在合理的范围内对会员或第三方在平台上发布的商业信息或交易信息进行检验，但并不对相关信息的真实性、合法性、准确性、完整性和有效性进行任何形式的担保或保证，且不承担会员基于该等信息进行的任何交易承担任何形式的法律责任。投资有风险，交易需谨慎，会员应基于自身的独立判断进行交易，并对其作出的判断或交易承担全部责任。</p><p><br></p><p>第十六条</p><p>以上并不能揭示会员通过盈满资管进行交易的全部风险及市场的全部情形。会员在做出交易决策前，应全面了解相关交易，谨慎决策，并自行承担全部风险。</p><p><br></p><p>第五章 服务费用</p><p>第十七条</p><p>会员使用盈满资管的服务，盈满资管有权向会员收取相关服务费用。各项服务费用详见会员使用盈满资管的服务时盈满资管平台上所列之收费方式说明。盈满资管保留单方面制定及调整服务费用的权利。</p><p>第十八条</p><p>会员在使用盈满资管的服务过程中（如充值或取现等）可能需要向第三方（如银行或第三方支付公司等）支付一定的费用，具体收费标准详见第三方网站相关页面，或盈满资管平台的提示。</p><p><br></p><p>第六章 账户安全及管理</p><p>第十九条</p><p>会员了解并同意，确保会员账户及密码的机密安全是会员的责任。会员将对利用该会员账户及密码所进行的一切行动及言论，负完全的责任，并同意以下事项：</p><p>1、会员不对其他任何人泄露账户或密码，亦不可使用其他任何人的账户或密码。因黑客、病毒或会员的保管疏忽等非盈满资管原因导致会员的会员账户遭他人非法使用的，盈满资管不承担任何责任。</p><p>2、盈满资管通过会员的会员账户及密码来识别会员的指令。会员确认，使用会员账户和密码登陆后，以该会员账户的名义在盈满资管进行的一切行为均代表会员本人的行为。会员账户操作所产生的电子信息记录均为会员行为的有效凭据，并由会员本人承担由此产生的全部责任。</p><p>3、冒用他人账户及密码的，盈满资管及其合法授权主体保留追究实际使用人连带责任的权利。</p><p>4、会员应根据盈满资管的相关规则以及盈满资管平台的相关提示创建一个安全密码，会员的密码设置应符合盈满资管规定的密码设置规则，应避免选择过于明显的单词或日期，比如会员的姓名、昵称或者生日等。</p><p><br></p><p>第二十条</p><p>会员如发现有第三人冒用或盗用会员账户及密码，或其他任何未经合法授权账户的情形，应立即以有效方式通知盈满资管，要求盈满资管暂停相关服务。否则，由此产生的一切责任由会员本人承担。同时，会员理解盈满资管对会员的请求采取行动需要合理期限，在此之前，盈满资管对第三人非法使用该服务所导致的损失不承担任何责任。</p><p><br></p><p>第二十一条</p><p>会员决定不再使用会员账户时，应首先清偿所有应付款项（包括但不限于借款本金、利息、罚息、违约金、服务费、管理费等），再将会员账户中的可用款项（如有）全部取现或者向盈满资管发出其它合法的支付指令，并向盈满资管申请注销该会员账户，经盈满资管审核同意后可正式注销会员账户。</p><p><br></p><p>会员死亡或被宣告死亡的，其在本协议项下的各项权利义务由其继承人承担，但其继承人应按照平台的要求提供相应的证明文件。若会员丧失全部或部分民事权利能力或民事行为能力，盈满资管或其授权的主体有权根据有效法律文书（包括但不限于生效的法院判决等）或其法定监护人的指示处置与会员账户相关的款项。</p><p><br></p><p>第二十二条</p><p>盈满资管有权基于单方独立判断，在其认为可能发生危害交易安全等情形时，不经通知而先行暂停、中断或终止向会员提供本协议项下的全部或部分会员服务（包括收费服务），且无需对会员或任何第三方承担任何责任。前述情形包括但不限于：</p><p>1、盈满资管认为会员提供的个人资料不具有真实性、有效性或完整性。</p><p>2、盈满资管发现异常交易或有疑义或有违法之虞时。</p><p>3、盈满资管认为会员账户涉嫌洗钱、套现、传销、被冒用或其他盈满资管认为有风险之情形。</p><p>4、盈满资管认为会员已经违反本协议中规定的各类规则。</p><p>5、会员在使用盈满资管收费服务时未按规定向盈满资管支付相应的服务费用。</p><p>6、会员账户已连续三年内未实际使用且账户中余额为零。</p><p>7、盈满资管基于交易安全等原因，根据其单独判断需先行暂停、中断或终止向会员提供本协议项下的全部或部分会员服务（包括收费服务）。</p><p>8、盈满资管基于其他第三方的请求，并在第三方提供初步的证据或材料对其请求予以确认时。</p><p><br></p><p>第二十三条</p><p>如发生上述第二十二条之情形，会员应在盈满资管通知的合理期限内进行解释、说明或予以纠正，否则盈满资管有权终止提供会员账户服务，并有权暂停、关闭或删除会员账户及该会员账户中所有相关资料及档案。盈满资管对因实施该等行为而导致会员发生的任何损失，不承担任何责任。</p><p><br></p><p>第二十四条&nbsp;</p><p>会员同意，会员账户的暂停、中断或终止不代表会员责任的终止，会员仍应对使用盈满资管服务期间的行为承担可能的违约或损害赔偿责任，同时盈满资管仍可保有会员的相关信息。</p><p><br></p><p>第七章 会员的守法义务及承诺</p><p>第二十五条</p><p>会员承诺绝不为任何非法目的或以任何非法方式使用盈满资管服务，并承诺遵守中国相关法律、法规及一切使用互联网之国际惯例，遵守所有与盈满资管服务有关的网络协议、规则和程序。</p><p><br></p><p>第二十六条</p><p>会员同意并保证不得利用盈满资管服务从事侵害他人权益或违法之行为，若有违反者应负所有法律责任。上述行为包括但不限于：&nbsp;</p><p>1、反对宪法所确定的基本原则，危害国家安全、泄漏国家秘密、颠覆国家政权、破坏国家统一的。</p><p>2、侵害他人名誉、隐私权、商业秘密、商标权、著作权、专利权、其他知识产权及其他权益。</p><p>3、违反依法律或合约所应负之保密义务。</p><p>4、冒用他人名义使用盈满资管服务。</p><p>5、从事任何不法交易行为，如贩卖枪支、毒品、禁药、盗版软件或其他违禁物。</p><p>6、提供赌博资讯或以任何方式引诱他人参与赌博。</p><p>7、涉嫌洗钱、套现或进行传销活动的。</p><p>8、从事任何可能含有电脑病毒或是可能侵害盈满资管服务系統、资料等行为。</p><p>9、利用盈满资管服务系统进行可能对互联网或移动网正常运转造成不利影响之行为。</p><p>10、侵犯盈满资管的商业利益，包括但不限于发布非经盈满资管许可的商业广告。</p><p>11、利用盈满资管服务上传、展示或传播虚假的、骚扰性的、中伤他人的、辱骂性的、恐吓性的、庸俗淫秽的或其他任何非法的信息资料。</p><p><br></p><p>12、其他盈满资管有正当理由认为不适当之行为。</p><p>第二十七条</p><p>盈满资管保有依其单独判断删除盈满资管内各类不符合法律政策或不真实或不适当的信息内容而无须通知会员的权利，并无需承担任何责任。</p><p><br></p><p>第二十八条</p><p>会员同意，由于会员违反本协议，或违反通过援引本协议并成为本协议一部分的文件，或由于会员使用盈满资管服务违反了任何法律或第三方的权利而造成任何第三方进行或发起的任何补偿申请或要求（包括律师费用），会员会对盈满资管及其关联方、合作伙伴给予全额补偿，并使之不受损害。</p><p><br></p><p>第二十九条</p><p>会员承诺，其向平台提供的或通过盈满资管平台上传或发布的信息均真实、合法、有效。如因违背上述承诺，造成盈满资管或盈满资管及其他使用方损失的，会员将承担相应责任。</p><p><br></p><p>第八章 服务中断或故障</p><p>第三十条</p><p>会员同意，基于互联网的特殊性，盈满资管不担保平台服务不会中断，也不担保平台服务的及时性和/或安全性。系统因相关状况无法正常运作，使会员无法使用任何盈满资管服务或使用任何盈满资管服务时受到任何影响时，盈满资管对会员或第三方不负任何责任，前述状况包括但不限于：</p><p>1、盈满资管系统停机维护期间。</p><p>2、电信设备出现故障不能进行数据传输的。</p><p>3、由于黑客攻击、网络供应商技术调整或故障、网站升级、银行方面的问题等原因而造成的盈满资管服务中断或延迟。</p><p>4、因台风、地震、海啸、洪水、停电、战争、恐怖袭击等不可抗力之因素，造成盈满资管系统障碍不能运行的。</p><p><br></p><p>第九章 责任范围及限制</p><p>第三十一条</p><p>盈满资管未对任何盈满资管服务提供任何形式的保证，包括但不限于以下事项：</p><p>1、盈满资管服务将符合会员的需求。</p><p>2、盈满资管服务将不受干扰、及时提供或免于出错。</p><p>3、会员经由盈满资管服务购买或取得之任何产品、服务、资讯或其他资料将符合会员的期望。</p><p><br></p><p>第三十二条</p><p>盈满资管服务的合作单位所提供的服务品质及内容由该合作单位自行负责。盈满资管的内容可能涉及由第三方所有、控制或者运营的其他网站（以下简称“第三方网站”）， 盈满资管不能保证也没有义务保证第三方网站上任何信息均真实、合法和有效。会员确认按照第三方网站的服务协议使用第三方网站。第三方网站不是盈满资管推荐或者介绍的，第三方网站的内容、产品、广告和其他任何信息均由会员自行判断并承担风险。</p><p><br></p><p>第三十三条</p><p>会员自盈满资管及盈满资管工作人员或经由盈满资管服务取得的建议或资讯，无论其为书面或口头，均不构成盈满资管对盈满资管服务的任何保证。</p><p><br></p><p>第三十四条</p><p>盈满资管不保证为向会员提供便利而设置的外部链接的真实、合法、有效和安全性。同时，对于该等外部链接指向的不由盈满资管实际控制的任何网页上的内容，盈满资管不承担任何责任。如会员或其他第三方认为该等链接的内容违法或可能侵犯会员或第三方合法利益的，其有权向盈满资管投诉并要求采取移除、断开链接等处理。</p><p><br></p><p>第三十五条</p><p>除本协议另有规定外，在任何情况下，盈满资管对应提供本协议服务所承担的违约赔偿责任总额不超过向会员收取的当次盈满资管服务费用总额。</p><p><br></p><p>第十章 隐私权保护及授权条款</p><p>第三十六条</p><p>盈满资管对于会员提供的或自行收集的会员信息将按照相关法律法规或本协议予以保护、使用或者披露。在上述范围内，盈满资管无需会员同意，即可在不损害会员合法权益的情况下使用相关信息。</p><p><br></p><p>第三十七条</p><p>盈满资管可能自公开渠道或其他来源收集会员的资料，以提高平台服务质量，或确保会员在盈满资管平台进行安全交易。</p><p><br></p><p>第三十八条</p><p>盈满资管有权基于会员在盈满资管平台上进行的交易或其他行为进行自动追踪或记录有关会员的其他资料。在不损害会员合法权益的前提下，盈满资管有权对整个会员数据库进行分析，并对会员数据库及其分析结果进行商业上的利用。</p><p><br></p><p>第三十九条</p><p>会员同意，为收集会员资料，盈满资管可在盈满资管平台的某些网页上使用诸如“Cookies”的资料收集装置等插件或设备。</p><p><br></p><p>第四十条</p><p>会员同意盈满资管可使用关于会员的相关资料以解决争议或对纠纷进行调停。会员同意盈满资管可通过人工或自动程序对会员的资料进行评价。</p><p><br></p><p>第四十一条</p><p>盈满资管采用行业标准惯例以保护会员的资料。对于会员的个人信息，盈满资管承诺不会恶意出售、泄露或免费共享给任何第三方使用，但以下情况除外：</p><p>1、为平台提供独立服务，且仅要求提供服务相关的必要信息并承诺采取不低于平台对会员信息保密措施的供应商、服务商等，如印刷厂、邮递公司。</p><p>2、具有合法调阅信息权限，并采取合法手续调阅会员信息的政府部门或其他机构，如公安机关、法院。</p><p>3、承诺采取不低于平台对会员信息保密措施的盈满资管的关联实体。</p><p>4、经平台使用方或平台使用方授权代表同意的第三方。</p><p><br></p><p>第四十二条</p><p>盈满资管有义务根据有关法律要求向司法机关和政府部门提供会员的个人资料。在会员未能按照与盈满资管签订的服务协议或者与盈满资管其他会员签订的协议等其他法律文本的 约定履行自己应尽的义务时，盈满资管有权根据自己的判断，或者与该笔交易有关的其他会员的请求披露会员的个人信息和资料，并做出评论。</p><p><br></p><p>会员严重违反盈满资管的相关规则时，盈满资管有权对会员资料进行编辑并加入平台黑名单，并将该黑名单向社会公众或其他第三方披露，且盈满资管有权未追究会员责任之目的，在合理的范围内将会员个人信息与任何第三方进行共享，以便网站和第三方催收逾期借款及对会员的其他申请进行审核之用，由此可能造成的任何损失由会员自己承担。</p><p><br></p><p>第十一章 知识产权的保护</p><p>第四十三条</p><p>盈满资管平台上所有内容，包括但不限于文字、图片、音频及视频等相关作品、平台的架构、画面安排、网页设计等软件作品的著作权，及其他商标权、专利权或商业秘密等知识产权均由盈满资管或其他权利人依法拥有。</p><p><br></p><p>第四十四条</p><p>非经盈满资管或其他权利人书面同意，任何人不得擅自使用、修改、复制、公开传播、上述知识产权及其客体。</p><p><br></p><p>第四十五条</p><p>会员未经盈满资管的明确书面同意，不许下载（除了页面缓存）或修改平台或其任何部分。会员不得对盈满资管平台或其内容进行转售或商业利用；不得收集和利用产品目录、说明和价格；不得对盈满资管平台或其内容进行任何衍生利用；不得为其他商业利益而下载或拷贝账户信息或使用任何数据采集、Robots或类似的数据收集 和摘录工具。未经盈满资管的书面许可，严禁对盈满资管的内容进行系统获取以直接或间接创建或编辑文集、汇编、数据库或人名地址录。另外，严禁为任何未经本使用条件明确允许的目的而使用盈满资管平台上的内容和材料。</p><p><br></p><p>第四十六条</p><p>未经盈满资管明确书面同意，不得以任何商业目的对盈满资管网站或其任何部分进行复制、复印、仿造、出售、转售、访问、或以其他方式加以利用。未经盈满资管明确书面同意，会员不得用任何技术手段把盈满资管或其关联公司的商标、标识或其他专有信息（包括图像、文字、网页设计或形式）据为己有。任何未经授权的使用都会终止赚帮所授予的允许或许可。</p><p><br></p><p>第四十七条</p><p>如有违反，会员对违反知识产权保护条款对盈满资管、盈满资管网站及任何第三方产生的损害均负有承担损害赔偿等法律责任。</p><p><br></p><p>第十二章 条款的解释、法律适用及争端解决</p><p>第四十八条</p><p>本协议是由会员与盈满资管共同签订的，适用于会员在盈满资管的全部活动。本协议内容包括但不限于协议正文条款及已经发布的或将来可能发布的各类规则，所有条款和规则为协议不可分割的一部分，与协议正文具有同等法律效力。</p><p><br></p><p>第四十九条</p><p>本协议不涉及会员与盈满资管的其他会员之间，因网上交易而产生的法律关系及法律纠纷。但会员在此同意将全面接受并履行与盈满资管其他会员在盈满资管签订的任何电子法律文本，并承诺按照该法律文本享有和（或）放弃相应的权利、承担和（或）豁免相应的义务。</p><p><br></p><p>第五十条</p><p>如本协议中的任何条款无论因何种原因完全或部分无效或不具有执行力，则应认为该条款可与本协议相分割，并可被尽可能接近各方意图的、能够保留本协议要求的经济目的的、有效的新条款所取代，而且，在此情况下，本协议的其他条款仍然完全有效并具有约束力。</p><p><br></p><p>第五十一条</p><p>盈满资管对本服务协议拥有最终的解释权。</p><p><br></p><p>第五十二条</p><p>本协议及其修订的有效性、履行与本协议及其修订效力有关的所有事宜，将受中国法律管辖，任何争议仅适用中国法律。</p><p><br></p><p>第五十三条</p><p>因本协议所引起的会员与盈满资管的任何纠纷或争议，首先应友好协商解决，协商不成的，会员在此完全同意将纠纷或争议提交盈满资管所在地有管辖权的人民法院诉讼解决。</p></div>',
           ),
         )
       ],
     ),
   );
  }

}