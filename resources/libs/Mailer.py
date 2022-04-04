import smtplib
import ssl
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart


class Mailer(object):

    port = 465

    def __init__(self, username='', password='', to='xxxxxx@gmail.com'):
        self.username = username
        self.password = password
        self.to = to.split(',')
        self.atual = 'alz1'

        self.body_pa = """
    <html>
      <body>
      <style type="text/css">
        .tg  {border-collapse:collapse;border-color:#93a1a1;border-spacing:0;}
        .tg td{background-color:#fdf6e3;border-bottom-width:1px;border-color:#93a1a1;border-style:solid;border-top-width:1px;border-width:0px;color:#002b36;font-family:Arial, sans-serif;font-size:14px;overflow:hidden;padding:10px 5px;word-break:normal;}
        .tg th{background-color:#657b83;border-bottom-width:1px;border-color:#93a1a1;border-style:solid;border-top-width:1px;border-width:0px;color:#fdf6e3;font-family:Arial, sans-serif;font-size:14px;font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
        .tg .tg-alz1{background-color:#eee8d5;text-align:left;vertical-align:top}
        .tg .tg-amwm{font-weight:bold;text-align:center;vertical-align:top}
        .tg .tg-0lax{text-align:left;vertical-align:top}
        </style>
        <table class="tg" style="undefined;table-layout: fixed; width: 520px">
        <colgroup>
          <col style="width: 118px">
          <col style="width: 104px">
          <col style="width: 96px">
          <col style="width: 115px">
          <col style="width: 87px">
        </colgroup>
        <thead>
          <tr>
            <th class="tg-amwm">Processo assincrono</th>
            <th class="tg-amwm">Job</th>
            <th class="tg-amwm">Status</th>
            <th class="tg-amwm">Ultima Exec</th>
            <th class="tg-amwm">Erro</th>
          </tr>
        </thead>
        <tbody>
          prime_content
        </tbody>
        </table>
      </body>
    </html>
    """

        self.body_se = """
    <html>
      <body>
      <style type="text/css">
        .tg  {border-collapse:collapse;border-color:#93a1a1;border-spacing:0;}
        .tg td{background-color:#fdf6e3;border-bottom-width:1px;border-color:#93a1a1;border-style:solid;border-top-width:1px;border-width:0px;color:#002b36;font-family:Arial, sans-serif;font-size:14px;overflow:hidden;padding:10px 5px;word-break:normal;}
        .tg th{background-color:#657b83;border-bottom-width:1px;border-color:#93a1a1;border-style:solid;border-top-width:1px;border-width:0px;color:#fdf6e3;font-family:Arial, sans-serif;font-size:14px;font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
        .tg .tg-alz1{background-color:#eee8d5;text-align:left;vertical-align:top}
        .tg .tg-amwm{font-weight:bold;text-align:center;vertical-align:top}
        .tg .tg-0lax{text-align:left;vertical-align:top}
        </style>
        <table class="tg" style="undefined;table-layout: fixed; width: 520px">
        <colgroup>
          <col style="width: 118px">
          <col style="width: 87px">
        </colgroup>
        <thead>
          <tr>
            <th class="tg-amwm">Serviço</th>
            <th class="tg-amwm">Erro</th>
          </tr>
        </thead>
        <tbody>
          prime_content
        </tbody>
        </table>
      </body>
    </html>
    """

    def build_body_pa(self, objs):
      self.results = ''
      for i in objs:
        self.results = self.results + i.replace('prime_type', self.atual)
        if self.atual == 'alz1':
          self.atual = '0lax'
        else:
          self.atual = 'alz1'
      self.body_pa = self.body_pa.replace('prime_content', self.results)
      self.content = MIMEText(self.body_pa, 'html')

    def build_body_se(self, objs):
      self.results = ''
      for i in objs:
        self.results = self.results + i.replace('prime_type', self.atual)
        if self.atual == 'alz1':
          self.atual = '0lax'
        else:
          self.atual = 'alz1'
      self.body_se = self.body_se.replace('prime_content', self.results)
      self.content = MIMEText(self.body_se, 'html')

    def build_plain(self, text):
      self.content = MIMEText(f"""{text}""", 'plain')

    def send_mail(self, title):
      self.message = MIMEMultipart("alternative")
      self.message["Subject"] = title
      self.message["From"] = 'Automated Reporter'
      self.message["To"] = ", ".join(self.to)
      self.message.attach(self.content)
      self.context = ssl.create_default_context()

      with smtplib.SMTP_SSL("smtp.gmail.com", 465, context=self.context) as server:
        server.login(self.username, self.password)
        server.sendmail(self.username, self.to, self.message.as_string())